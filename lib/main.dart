import 'package:ai_friend/domain/helpers/rate_app_helper.dart';
import 'package:ai_friend/features/bot_profile/bot_short_profile.dart';
import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/chat_screen.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_storage.dart';
import 'package:ai_friend/features/chat/chat_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/firebase_options.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/features/onboarding/onboarding_provider.dart';
import 'package:ai_friend/features/onboarding/onboarding_storage.dart';
import 'package:ai_friend/features/onboarding/start_screen.dart';
import 'package:ai_friend/features/profile/birthdate/birthdate_storage.dart';
import 'package:ai_friend/features/profile/gender/gender_storage.dart';
import 'package:ai_friend/features/profile/hobby/hobby_provider.dart';
import 'package:ai_friend/features/profile/hobby/hobby_storage.dart';
import 'package:ai_friend/features/profile/name/name_storage.dart';
import 'package:ai_friend/features/profile/profile_provider.dart';
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
  await BirthDateStorage.openStorage();
  await NameStorage.openStorage();
  await GenderStorage.openStorage();
  await HobbyStorage.openStorage();

  await locator<FirebaseConfig>().init();
  await locator<ChatScriptProvider>().initScript();
  await locator<ChatProvider>().createThread();
  await locator<ChatProvider>().initMessages();
  await locator<ProfileProvider>().init();
  await RateAppHelper.initPlagin();
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
        ChangeNotifierProvider(create: (_) => locator<ProfileProvider>()),
        ChangeNotifierProvider(create: (_) => locator<HobbyProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Friend',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: introWasShown ? const ChatScreen() : const StartScreen(),
        // home: const StartScreen(),
        home: const BotShortProfile(),
        // home: CircularImageViewer(),
      ),
    );
  }
}
