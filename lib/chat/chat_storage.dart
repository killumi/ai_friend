import 'dart:async';
import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatStorage {
  static const name = 'messages';
  Box<IChatMessage> get box => Hive.box(name);
  List<IChatMessage> get messages => box.values.toList();
  List<IChatMessage> get videos =>
      box.values.where((e) => e.type.contains('video')).toList();
  List<IChatMessage> get images =>
      box.values.where((e) => e.type.contains('image')).toList();

  List<IChatMessage> get media => box.values
      .where((e) => e.type.contains('video') || e.type.contains('image'))
      .toList();

  static openStorage() async {
    if (!Hive.isBoxOpen(name)) {
      Hive.registerAdapter(IChatMessageAdapter());
      await Hive.openBox<IChatMessage>(name);
    }
  }

  Future<void> addMessage(IChatMessage message) async {
    await box.add(message);
  }

  Future<void> clear() async {
    await box.clear();
  }
}
