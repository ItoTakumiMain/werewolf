import 'package:flutter_test/flutter_test.dart';
import 'dart:convert' as convert;
import 'package:werewolf/infrastructures/http_repositories/http_client.dart';
import 'package:werewolf/infrastructures/http_repositories/gpt_client.dart';
import 'package:werewolf/models/conversation.dart';
import 'package:werewolf/models/emotion.dart';

class FakeHttpClient implements HttpClient {
  final Map<String, dynamic> responseBody;

  FakeHttpClient({required this.responseBody});

  @override
  Future<Map<String, dynamic>> post(
      Uri url, Map<String, String> headers, dynamic body) async {
    return responseBody;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('正しい形式でレスポンスが返却された場合', () async {
    // 実際にcurlで確認したレスポンスボディ
    final Map<String, dynamic> fakeResponse = convert.jsonDecode(
        '{"id":"chatcmpl-7Dsuw9Qo7dhQvNKsMbWlYyrd4HzYR","object":"chat.completion","created":1683543722,"model":"gpt-3.5-turbo-0301","usage":{"prompt_tokens":14,"completion_tokens":5,"total_tokens":19},"choices":[{"message":{"role":"assistant","content":""},"finish_reason":"stop","index":0}]}');
    fakeResponse['choices'][0]['message']['content'] =
        '{"emotion": "fun", "message": "This is a test!"}';

    final HttpClient fakeHttpClient =
        FakeHttpClient(responseBody: fakeResponse);
    final GptClientResponse actual = await GptClient(httpClient: fakeHttpClient)
        .request('', Conversation(messages: []));

    expect(actual.message, equals('This is a test!'),
        reason: 'fakeResponseで設定したmessageが返ってくるべき');
    expect(actual.emotion, equals(Emotion.fun),
        reason: 'fakeResponseで設定したemotionが返ってくるべき');
  });

  group('間違った形式でレスポンスが返却された場合', () {
    test('jsonにパースできないようなフォーマットの場合', () async {
      // 実際にcurlで確認したレスポンスボディ
      final Map<String, dynamic> fakeResponse = convert.jsonDecode(
          '{"id":"chatcmpl-7Dsuw9Qo7dhQvNKsMbWlYyrd4HzYR","object":"chat.completion","created":1683543722,"model":"gpt-3.5-turbo-0301","usage":{"prompt_tokens":14,"completion_tokens":5,"total_tokens":19},"choices":[{"message":{"role":"assistant","content":""},"finish_reason":"stop","index":0}]}');
      fakeResponse['choices'][0]['message']['content'] = 'invalid_response';

      final HttpClient fakeHttpClient =
          FakeHttpClient(responseBody: fakeResponse);
      final GptClient gptClient = GptClient(httpClient: fakeHttpClient);

      expect(
          () async => await gptClient.request('', Conversation(messages: [])),
          throwsA(isA<GptClientInvalidResponseException>()),
          reason: '例外が発生するべき');
    });

    test('パースしたjsonの形式が期待しているものでない場合', () async {
      // 実際にcurlで確認したレスポンスボディ
      final Map<String, dynamic> fakeResponse = convert.jsonDecode(
          '{"id":"chatcmpl-7Dsuw9Qo7dhQvNKsMbWlYyrd4HzYR","object":"chat.completion","created":1683543722,"model":"gpt-3.5-turbo-0301","usage":{"prompt_tokens":14,"completion_tokens":5,"total_tokens":19},"choices":[{"message":{"role":"assistant","content":""},"finish_reason":"stop","index":0}]}');
      fakeResponse['choices'][0]['message']['content'] =
          'fun", "invalid_message": "This is a test!"}';

      final HttpClient fakeHttpClient =
          FakeHttpClient(responseBody: fakeResponse);
      final GptClient gptClient = GptClient(httpClient: fakeHttpClient);

      expect(
          () async => await gptClient.request('', Conversation(messages: [])),
          throwsA(isA<GptClientInvalidResponseException>()),
          reason: 'emotionがないので例外が発生するべき');
    });
  });
}
