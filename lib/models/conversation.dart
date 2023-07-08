import 'package:werewolf/models/message.dart';

class Conversation {
  final List<Message> messages;

  Conversation({required this.messages});

  Conversation add(Message message) {
    return Conversation(messages: [...messages, message]);
  }

  @override
  String toString() {
    return messages
        .map((message) => '${message.speaker}: ${message.content}')
        .join('\n');
  }
}
