import 'package:flutter_test/flutter_test.dart';
import 'package:werewolf/models/conversation.dart';
import 'package:werewolf/models/emotion.dart';
import 'package:werewolf/models/message.dart';

void main() {
  test('toStringの挙動が正しいこと', () async {
    final conversation = Conversation(messages: [
      Message(
          speaker: 'AI',
          content: '今日はいい天気ですね。',
          emotion: Emotion.neutral,
          now: DateTime.now()),
      Message(
          speaker: 'User',
          content: '何言ってるの？今日は雨だよ？',
          emotion: Emotion.neutral,
          now: DateTime.now()),
    ]);

    const expected = 'AI: 今日はいい天気ですね。\nUser: 何言ってるの？今日は雨だよ？';

    expect(conversation.toString(), equals(expected));
  });

  test('messageが空配列の場合は空文字列を返すこと', () async {
    final conversation = Conversation(messages: []);

    const expected = '';

    expect(conversation.toString(), equals(expected));
  });
}
