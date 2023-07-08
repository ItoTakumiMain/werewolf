import 'package:flutter/material.dart';
import 'package:werewolf/views/main/ai.dart';

class ViewsMainIndex extends StatelessWidget {
  const ViewsMainIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(5.0),
        child: const ViewsMainAi(),
      ),
    );
  }
}
