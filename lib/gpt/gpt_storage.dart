// import 'dart:async';
// import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class GptStorage {
//   static const name = 'messages';
//   Box<IChatMessage> get box => Hive.box(name);
//   List<IChatMessage> get messages => box.values.toList();
//   static openStorage() async {
//     if (!Hive.isBoxOpen(name)) {
//       Hive.registerAdapter(IChatMessageAdapter());
//       await Hive.openBox<IChatMessage>(name);
//     }
//   }

//   Future<void> addMessage(IChatMessage message) async {
//     await box.add(message);
//   }

//   Future<void> clear() async {
//     await box.clear();
//   }
// }
