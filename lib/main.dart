import 'package:ai_friend/firebase_options.dart';
import 'package:ai_friend/gpt/chat_script/chat_script_provider.dart';
import 'package:ai_friend/gpt/chat_script/chat_script_storage.dart';
import 'package:ai_friend/gpt/gpt_provider.dart';
import 'package:ai_friend/gpt/gpt_screen.dart';
import 'package:ai_friend/locator.dart';
// import 'package:ai_friend/test_img_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initLocator();
  await Hive.initFlutter();
  await ChatScriptStorage.openStorage();
  // await ChatScriptStorage().setCurrentDay(1);
  await locator<GPTProvider>().createThreads();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<GPTProvider>()),
        ChangeNotifierProvider(create: (_) => locator<ChatScriptProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Friend',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GptScreen(),
        // home: const TestImgScreen(),
      ),
    );
  }
}
