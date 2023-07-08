import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:werewolf/views/main/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ViewsMainIndex());
  }
}
