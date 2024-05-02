import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_storage.dart';
import 'package:ai_friend/features/chat/chat_storage.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/features/onboarding/onboarding_provider.dart';
import 'package:ai_friend/features/onboarding/onboarding_storage.dart';
import 'package:ai_friend/features/profile/birthdate/birthdate_storage.dart';
import 'package:ai_friend/features/profile/gender/gender_storage.dart';
import 'package:ai_friend/features/profile/hobby/hobby_provider.dart';
import 'package:ai_friend/features/profile/hobby/hobby_storage.dart';
import 'package:ai_friend/features/profile/name/name_storage.dart';
import 'package:ai_friend/features/profile/profile_provider.dart';
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

  locator.registerLazySingleton<NameStorage>(() => NameStorage());
  locator.registerLazySingleton<HobbyStorage>(() => HobbyStorage());
  locator
      .registerLazySingleton<FireStorageProvider>(() => FireStorageProvider());
  locator.registerLazySingleton<HobbyProvider>(
      () => HobbyProvider(locator<HobbyStorage>()));

  locator.registerLazySingleton<ProfileProvider>(
    () => ProfileProvider(
      BirthDateStorage(),
      GenderStorage(),
      locator<NameStorage>(),
    ),
  );
}
