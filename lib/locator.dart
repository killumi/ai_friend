import 'package:ai_friend/firebase/fire_storage.dart';
import 'package:ai_friend/firebase/firebase_config.dart';
import 'package:ai_friend/gpt/chat_script/chat_script_provider.dart';
import 'package:ai_friend/gpt/chat_script/chat_script_storage.dart';
import 'package:ai_friend/gpt/gpt_provider.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerLazySingleton<FirebaseConfig>(() => FirebaseConfig());
  locator.registerLazySingleton<ChatScriptProvider>(
    () => ChatScriptProvider(
      locator<FirebaseConfig>(),
      ChatScriptStorage(),
    ),
  );
  locator
      .registerLazySingleton<FireStorageProvider>(() => FireStorageProvider());
  locator.registerLazySingleton<GPTProvider>(() => GPTProvider());
}
