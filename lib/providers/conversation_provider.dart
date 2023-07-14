import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:werewolf/models/conversation.dart';
import 'package:werewolf/models/emotion.dart';
import 'package:werewolf/models/message.dart';

class ConversationNotifier extends StateNotifier<Conversation> {
  ConversationNotifier()
      : super(Conversation(messages: [
          Message(
              content: '',
              meaning: '',
              speaker: 'アイ',
              emotion: Emotion.neutral,
              now: DateTime.now())
        ]));

  void addMessage(Message message) => state = state.add(message);
}

final conversationProvider =
    StateNotifierProvider<ConversationNotifier, Conversation>((ref) {
  return ConversationNotifier();
});
