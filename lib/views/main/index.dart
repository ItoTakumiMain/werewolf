import 'package:flutter/material.dart';

class ViewsMainIndex extends StatelessWidget {
  const ViewsMainIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('テスト'),
            ]),
      ),
    );
  }
}
