import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/chat_screen.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_storage.dart';
import 'package:ai_friend/features/chat/chat_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/features/onboarding/onboarding_screen.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/firebase_options.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/features/onboarding/onboarding_provider.dart';
import 'package:ai_friend/features/onboarding/onboarding_storage.dart';
import 'package:ai_friend/features/profile/birthdate/birthdate_storage.dart';
import 'package:ai_friend/features/profile/gender/gender_storage.dart';
import 'package:ai_friend/features/profile/hobby/hobby_provider.dart';
import 'package:ai_friend/features/profile/hobby/hobby_storage.dart';
import 'package:ai_friend/features/profile/name/name_storage.dart';
import 'package:ai_friend/features/profile/profile_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final facebookSDK = FacebookAppEvents();
  // await facebookSDK.setAdvertiserTracking(enabled: true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initLocator();
  await locator<FirebaseConfig>().init();
  // Apphud.setListener(listener: ApphudPaymentListener());
  // TrackingHelper.requestTrackingAuthorization();
  await Hive.initFlutter();
  // await PaymentProvider.startApphud();
  await ChatScriptStorage.openStorage();
  await ChatStorage.openStorage();
  await OnboardingStorage.openStorage();
  await BirthDateStorage.openStorage();
  await NameStorage.openStorage();
  await GenderStorage.openStorage();
  await HobbyStorage.openStorage();
  // await RateAppStorage.openStorage();
  // Apphud.setListener(listener: ApphudPaymentListener());
  // await PaymentProvider.startApphud();
  locator<ChatProvider>().initOpenAI();
  await locator<ChatScriptProvider>().initScript();
  final name = locator<NameStorage>().name;
  if (name.isNotEmpty) {
    await locator<ChatProvider>().createThread();
  }
  await locator<ChatProvider>().initMessages();
  await locator<ProfileProvider>().init();
  // await SingularAnalitics.init();
  // await FirebaseAnaliticsService.init();
  // await RateAppHelper.initPlagin();
  // await PushNotificationService.initFirebaseMessaging();
  // await PushNotificationService.initOneSignal();
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
        child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          title: 'Lovevo',
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          navigatorKey: navigatorKey,
          home: introWasShown ? const ChatScreen() : const OnboardingScreen(),
        ),
      ),
    );
  }
}
