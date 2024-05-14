import 'package:ai_friend/domain/helpers/rate_app_helper.dart';
import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/chat_screen.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_storage.dart';
import 'package:ai_friend/features/chat/chat_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/features/payment/payment_listener.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/features/payment/payment_screen.dart';
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
import 'package:apphud/apphud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oktoast/oktoast.dart';
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
  await PaymentProvider.startApphud();
  Apphud.setListener(listener: ApphudPaymentListener());
  await PaymentProvider.startApphud();
  await locator<FirebaseConfig>().init();
  locator<ChatProvider>().initOpenAI();
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
    return OKToast(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => locator<OnboardingProvider>()),
          ChangeNotifierProvider(create: (_) => locator<ChatProvider>()),
          ChangeNotifierProvider(create: (_) => locator<ChatScriptProvider>()),
          ChangeNotifierProvider(create: (_) => locator<ProfileProvider>()),
          ChangeNotifierProvider(create: (_) => locator<HobbyProvider>()),
          ChangeNotifierProvider(create: (_) => locator<PaymentProvider>()),
        ],
        child: FutureBuilder(
          future: locator<PaymentProvider>().updatePremiumStatus(),
          builder: (context, snapshot) {
            final isHasPremium = snapshot.data ?? false;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'AI Girlfriend',
              home: introWasShown
                  ? isHasPremium
                      ? const ChatScreen()
                      : const PaymentScreen()
                  : const StartScreen(),
            );
          },
        ),
      ),
    );
  }
}
