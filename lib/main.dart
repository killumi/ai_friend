import 'dart:async';
import 'package:ai_friend/domain/firebase/fire_auth.dart';
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/domain/helpers/rate_app_helper.dart';
import 'package:ai_friend/domain/app_providers/connection_provider.dart';
import 'package:ai_friend/domain/services/push_notifications.dart';
import 'package:ai_friend/domain/analitics/singular_analitics.dart';
import 'package:ai_friend/domain/helpers/tracking_helper.dart';
import 'package:ai_friend/features/assistants/assistant_storage.dart';
import 'package:ai_friend/features/assistants/assistant_list_screen.dart';
import 'package:ai_friend/features/assistants/assistants_provider.dart';
import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/features/payment/payment_listener.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/features/payment/payment_screen.dart';
import 'package:ai_friend/firebase_options.dart';
import 'package:ai_friend/domain/services/locator.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FIREBASE INIT
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FIREBASE AUTH
  await Auth.signInAnonymously();
  // INIT LOCATOR
  await initLocator();
  // INIT FIREBASE CONFIG
  await locator<FirebaseConfig>().init();
  // PAYMENT
  await PaymentProvider.startApphud();
  Apphud.setListener(listener: ApphudPaymentListener());
  // TRACKING
  TrackingHelper.requestTrackingAuthorization();
  // INIT HIVE
  await Hive.initFlutter();
  // STORAGES
  await OnboardingStorage.openStorage();
  await BirthDateStorage.openStorage();
  await NameStorage.openStorage();
  await GenderStorage.openStorage();
  await HobbyStorage.openStorage();
  await RateAppStorage.openStorage();
  await AssistantStorage.openStorage();
  // LOAD ASSISTANT PROFILES
  await locator<AssistantsProvider>().updateAssistants();
  // INIT GPT
  locator<ChatProvider>().initOpenAI();
  await locator<ProfileProvider>().init();
  // ANALITICS INIT
  await SingularAnalitics.init();
  await FirebaseAnaliticsService.init();
  // RATE APP INIT
  await RateAppHelper.init();
  // PUSH NOTIFICATIONS
  await PushNotificationService.initFirebaseMessaging();
  await PushNotificationService.initOneSignal();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<List<ConnectivityResult>> connectSubscription;
  bool get introWasShown => locator<OnboardingStorage>().wasShown;

  @override
  dispose() {
    locator<ConnectivityProvider>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => locator<ConnectivityProvider>(),
          ),
          ChangeNotifierProvider(create: (_) => locator<OnboardingProvider>()),
          ChangeNotifierProvider(create: (_) => locator<ChatProvider>()),
          ChangeNotifierProvider(create: (_) => locator<ChatScriptProvider>()),
          ChangeNotifierProvider(create: (_) => locator<ProfileProvider>()),
          ChangeNotifierProvider(create: (_) => locator<HobbyProvider>()),
          ChangeNotifierProvider(create: (_) => locator<PaymentProvider>()),
          ChangeNotifierProvider(create: (_) => locator<AssistantsProvider>()),
        ],
        child: FutureBuilder(
          future: locator<PaymentProvider>().updatePremiumStatus(),
          builder: (context, snapshot) {
            final isHasPremium = snapshot.data ?? false;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Lovevo',
              navigatorKey: navigatorKey,
              home: introWasShown
                  ? isHasPremium
                      ? const AssistantListScreen()
                      : const PaymentScreen()
                  : const StartScreen(),
            );
          },
        ),
      ),
    );
  }
}
