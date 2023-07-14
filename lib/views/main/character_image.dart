import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:werewolf/models/conversation.dart';
import 'package:werewolf/models/emotion.dart';
import 'package:werewolf/providers/conversation_provider.dart';

class ViewsMainCharacterImage extends ConsumerWidget {
  const ViewsMainCharacterImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Conversation conversation = ref.watch(conversationProvider);
    final Emotion emotion = conversation.messages.isEmpty
        ? Emotion.neutral
        : ref.watch(conversationProvider).messages.last.emotion;
    final String imagePath =
        'assets/images/characters/sample/${emotion.name}.png';

    return Positioned(
        bottom: 0,
        right: 0,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Image.asset(imagePath));
  }
}
