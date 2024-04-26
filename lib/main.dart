import 'package:ai_friend/chat/chat_provider.dart';
import 'package:ai_friend/chat/chat_screen.dart';
import 'package:ai_friend/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/chat/chat_script/chat_script_storage.dart';
import 'package:ai_friend/chat/chat_storage.dart';
import 'package:ai_friend/firebase/firebase_config.dart';
import 'package:ai_friend/firebase_options.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/onboarding/onboarding_provider.dart';
import 'package:ai_friend/onboarding/onboarding_storage.dart';
import 'package:ai_friend/onboarding/start_screen.dart';
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
  await ChatStorage.openStorage();
  await OnboardingStorage.openStorage();
  await locator<FirebaseConfig>().init();
  await locator<ChatScriptProvider>().initScript();
  await locator<ChatProvider>().createThread();
  await locator<ChatProvider>().initMessages();

  // await ChatScriptStorage().setCurrentDay(1);
  // await locator<GPTProvider>().createThreads();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  bool get introWasShown => locator<OnboardingStorage>().wasShown;
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<OnboardingProvider>()),
        ChangeNotifierProvider(create: (_) => locator<ChatProvider>()),
        ChangeNotifierProvider(create: (_) => locator<ChatScriptProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Friend',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: introWasShown ? const ChatScreen() : const StartScreen(),
        // home: FlightStateDemoPage(),
        // home: FadeScaleTransitionDemo(),
        // home: OpenContainerTransformDemo(),
        // home: const OnboardingScreen(),
        // home: const ChatScreen(),
        // home: BubbleScreen(),
        // home: const GptScreen(),
        // home: AnimatedListExample(),
      ),
    );
  }
}
