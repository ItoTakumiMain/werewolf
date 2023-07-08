import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:werewolf/infrastructures/http_repositories/gpt_client.dart';
import 'package:werewolf/infrastructures/http_repositories/http_client.dart';
import 'package:werewolf/views/main/index.dart';

final httpClientProvider = Provider((ref) => HttpClient());
final gptClientProvider = Provider((ref) {
  final HttpClient httpClient = ref.watch(httpClientProvider);
  return GptClient(httpClient: httpClient);
});

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ViewsMainIndex());
  }
}
