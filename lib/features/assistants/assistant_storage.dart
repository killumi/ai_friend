import 'dart:async';
import 'dart:developer';
import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AssistantStorage {
  static const name = 'assistant';
  Box<IAssistant> get box => Hive.box(name);
  List<IAssistant> get profiles => box.values.toList();

  static openStorage() async {
    if (!Hive.isBoxOpen(name)) {
      Hive.registerAdapter(IChatMessageAdapter());
      Hive.registerAdapter(IAssistantAdapter());
      await Hive.openBox<IAssistant>(name);
    }
  }

  Future<void> update(IAssistant profile) async {
    final existing = profiles.firstWhereOrNull((p) => p.id == profile.id);
    if (existing == null) {
      log('existing PROFILE is NULL, ADD NEW: ${profile.toString()}');
      await box.add(profile);
      return;
    }

    if (existing != profile) {
      log('existing PROFILE WAS CHANCHED, UPDATE: ${profile.toString()}');
      final existingProfileKey = box.keys.firstWhere(
        (key) => box.get(key)?.id == profile.id,
      );
      await box.put(
        existingProfileKey,
        profile.copyWith(
          messages: existing.messages,
          scriptDayIndex: existing.scriptDayIndex,
          scriptMessageIndex: existing.scriptMessageIndex,
        ),
      );
      return;
    }

    log('NO NEED ANY CHANGES');
  }

  Future<void> clear() async {
    await box.clear();
  }
}
