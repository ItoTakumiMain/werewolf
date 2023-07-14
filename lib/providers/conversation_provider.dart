import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:werewolf/models/conversation.dart';
import 'package:werewolf/models/message.dart';

class ConversationNotifier extends StateNotifier<Conversation> {
  ConversationNotifier() : super(Conversation(messages: []));

  void addMessage(Message message) => state = state.add(message);
}

final conversationProvider =
    StateNotifierProvider<ConversationNotifier, Conversation>((ref) {
  return ConversationNotifier();
});
