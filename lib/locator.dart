import 'package:ai_friend/chat/chat_provider.dart';
import 'package:ai_friend/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/chat/chat_script/chat_script_storage.dart';
import 'package:ai_friend/chat/chat_storage.dart';
import 'package:ai_friend/firebase/fire_storage.dart';
import 'package:ai_friend/firebase/firebase_config.dart';
import 'package:ai_friend/onboarding/onboarding_provider.dart';
import 'package:ai_friend/onboarding/onboarding_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerLazySingleton<FirebaseConfig>(() => FirebaseConfig());
  locator.registerLazySingleton<OnboardingStorage>(() => OnboardingStorage());
  locator.registerLazySingleton<OnboardingProvider>(
      () => OnboardingProvider(locator<OnboardingStorage>()));

  locator.registerLazySingleton<ChatStorage>(() => ChatStorage());
  locator.registerLazySingleton<ChatScriptStorage>(() => ChatScriptStorage());

  locator.registerLazySingleton<ChatScriptProvider>(
    () => ChatScriptProvider(
      locator<FirebaseConfig>(),
      locator<ChatScriptStorage>(),
    ),
  );

  locator.registerLazySingleton<ChatProvider>(
    () => ChatProvider(
      locator<ChatStorage>(),
      locator<ChatScriptProvider>(),
    ),
  );

  locator
      .registerLazySingleton<FireStorageProvider>(() => FireStorageProvider());
}
