import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:werewolf/infrastructures/http_repositories/http_client.dart';
import 'package:werewolf/models/conversation.dart';
import 'package:werewolf/models/emotion.dart';

class GptClientInvalidResponseException implements Exception {}

class GptClient {
  final HttpClient httpClient;

  GptClient({required this.httpClient});

  Future<GptClientResponse> request(String query, Conversation context) async {
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer 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',
    };
    final String promptWithOutContext =
        await rootBundle.loadString('assets/gpt_client/prompt.txt');
    final String prompt =
        promptWithOutContext.replaceAll('{conversation}', context.toString());

    const responseStartWith = '';
    final Map<String, dynamic> requestBody = {
      'model': 'gpt-3.5-turbo-0613',
      'messages': [
        {'role': 'system', 'content': prompt},
        {'role': 'user', 'content': query},
        {'role': 'assistant', 'content': responseStartWith}
      ],
      'temperature': 1
    };

    final Map<String, dynamic> responseBody = await httpClient.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers,
        requestBody);

    final String content =
        '$responseStartWith${responseBody['choices'][0]['message']['content']}';

    try {
      final Map<String, dynamic> contentJson = jsonDecode(content);
      if (_invalidJsonStyle(contentJson)) {
        throw GptClientInvalidResponseException();
      }
      return GptClientResponse(
          message: contentJson['message'].toString(),
          emotion: Emotion.values.byName(contentJson['emotion'].toString()));
    } on FormatException catch (_) {
      throw GptClientInvalidResponseException();
    }
  }

  bool _invalidJsonStyle(Map<String, dynamic> contentJson) {
    return contentJson['message'] == null || contentJson['emotion'] == null;
  }
}

class GptClientResponse {
  final String message;
  final Emotion emotion;
  GptClientResponse({required this.message, required this.emotion});
}
