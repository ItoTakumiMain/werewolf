import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:werewolf/infrastructures/http_repositories/gpt_client.dart';
import 'package:werewolf/main.dart';
import 'package:werewolf/models/emotion.dart';
import 'package:werewolf/models/message.dart';
import 'package:werewolf/providers/conversation_provider.dart';

class ViewsMainTerminal extends ConsumerWidget {
  const ViewsMainTerminal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    final conversation = ref.watch(conversationProvider);

    void onSubmitted(String command) async {
      textController.clear();

      ref.read(conversationProvider.notifier).addMessage(Message(
          speaker: 'User',
          content: command,
          meaning: '',
          emotion: Emotion.neutral,
          now: DateTime.now()));

      final GptClient gptClinet = ref.watch(gptClientProvider);
      final response = await gptClinet.request(command, conversation);
      ref.read(conversationProvider.notifier).addMessage(Message(
          speaker: 'アイ',
          content: response.message,
          meaning: response.meaning,
          emotion: response.emotion,
          now: DateTime.now()));
    }

    return Positioned(
        bottom: 0,
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        child: Container(
            color: Colors.black.withOpacity(0.6),
            child: Column(children: [
              Text(
                conversation.messages.last.content,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              TextField(controller: textController, onSubmitted: onSubmitted),
            ])));
  }
}
