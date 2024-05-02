import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';

class ChatScriptStorage {
  static const name = 'chat_script_config';
  Box<int> get box => Hive.box(name);

  int get currentDay => box.get('current_script_day') ?? 1;
  int get currentMessage => box.get('current_script_message') ?? 0;

  static openStorage() async {
    if (!Hive.isBoxOpen(name)) {
      await Hive.openBox<int>(name);
    }
  }

  Future<void> setCurrentDay(int value) async {
    await box.put('current_script_day', value);
  }

  Future<void> setCurrentMessage(int value) async {
    await box.put('current_script_message', value);
  }

  Future<void> clear() async {
    await box.clear();
  }
}
