import 'package:ai_friend/domain/firebase/fire_database.dart';
import 'package:ai_friend/domain/helpers/rate_app_helper.dart';
import 'package:ai_friend/domain/app_providers/connection_provider.dart';
import 'package:ai_friend/features/assistants/assistant_storage.dart';
import 'package:ai_friend/features/assistants/assistants_provider.dart';
import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/features/onboarding/onboarding_provider.dart';
import 'package:ai_friend/features/onboarding/onboarding_storage.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/features/profile/birthdate/birthdate_storage.dart';
import 'package:ai_friend/features/profile/gender/gender_storage.dart';
import 'package:ai_friend/features/profile/hobby/hobby_provider.dart';
import 'package:ai_friend/features/profile/hobby/hobby_storage.dart';
import 'package:ai_friend/features/profile/name/name_storage.dart';
import 'package:ai_friend/features/profile/profile_provider.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // firebase
  locator.registerLazySingleton<FirebaseConfig>(() => FirebaseConfig());
  locator.registerLazySingleton<FireDatabase>(() => FireDatabase());
  // locator.registerLazySingleton<FireStorage>(() => FireStorage());
  locator.registerLazySingleton<FireStorage>(() => FireStorage());
  // local storages
  locator.registerLazySingleton<AssistantStorage>(() => AssistantStorage());
  locator.registerLazySingleton<OnboardingStorage>(() => OnboardingStorage());
  // locator.registerLazySingleton<ChatStorage>(() => ChatStorage());
  // locator.registerLazySingleton<ChatScriptStorage>(() => ChatScriptStorage());
  locator.registerLazySingleton<RateAppStorage>(() => RateAppStorage());
  locator.registerLazySingleton<NameStorage>(() => NameStorage());
  locator.registerLazySingleton<HobbyStorage>(() => HobbyStorage());
  // services
  locator.registerLazySingleton<ConnectivityProvider>(
      () => ConnectivityProvider());
  // state providers
  locator.registerLazySingleton<OnboardingProvider>(
      () => OnboardingProvider(locator<OnboardingStorage>()));

  locator.registerLazySingleton<AssistantsProvider>(() =>
      AssistantsProvider(locator<FireDatabase>(), locator<AssistantStorage>()));

  locator.registerLazySingleton<ChatScriptProvider>(
    () => ChatScriptProvider(
      locator<AssistantsProvider>(),
      locator<FireDatabase>(),
    ),
  );

  locator.registerLazySingleton<ChatProvider>(
    () => ChatProvider(
      locator<AssistantsProvider>(),
      locator<ChatScriptProvider>(),
    ),
  );

  locator.registerLazySingleton<PaymentProvider>(() => PaymentProvider());
  locator.registerLazySingleton<HobbyProvider>(
    () => HobbyProvider(locator<HobbyStorage>()),
  );

  locator.registerLazySingleton<ProfileProvider>(
    () => ProfileProvider(
      BirthDateStorage(),
      GenderStorage(),
      locator<NameStorage>(),
    ),
  );
}
