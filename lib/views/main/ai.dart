import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:werewolf/infrastructures/http_repositories/gpt_client.dart';
import 'package:werewolf/main.dart';

class ViewsMainAi extends StatelessWidget {
  const ViewsMainAi({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final GptClient gptClinet = ref.watch(gptClientProvider);
      return FutureBuilder<GptClientResponse>(
        future: gptClinet.request('おはよう。今日もいい天気だね。'),
        builder:
            (BuildContext context, AsyncSnapshot<GptClientResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Stack(
              children: <Widget>[
                Positioned(
                    bottom: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Image.asset(
                        'assets/images/characters/sample/${snapshot.data!.emotion.name}.png')),
                Positioned(
                  bottom: 0,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    child: Text(
                      snapshot.data!.message,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      );
    });
  }
}
