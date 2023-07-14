import 'package:werewolf/models/emotion.dart';

class Message {
  final String speaker;
  final String content;
  final String meaning;
  final Emotion emotion;
  final DateTime spokeAt;

  Message(
      {required this.speaker,
      required this.content,
      required this.meaning,
      required this.emotion,
      required DateTime now})
      : spokeAt = now;
}
