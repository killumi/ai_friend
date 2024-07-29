// import 'dart:async';
// import 'dart:developer';
// import 'dart:typed_data';
// import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';
// import 'package:collection/collection.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class AssistantProfileImagesStorage {
//   static const name = 'assistant_profile_images';
//   Box<List<Uint8List>> get box => Hive.box(name);

//   static openStorage() async {
//     if (!Hive.isBoxOpen(name)) {
//       await Hive.openBox<List<Uint8List>>(name);
//     }
//   }

//   Future<void> update(String assistantId, Uint8List image) async {
//     final saved = getProfileImages(assistantId);

//     if (saved.isEmpty) {
//       log('ADD NEW Photo to: $assistantId');
//       await box.put(assistantId, [image]);
//       return;
//     }

//     log('NO NEED ANY CHANGES');
//   }

//   bool _compareImages(Uint8List img1, Uint8List img2) {
//     return const ListEquality().equals(img1, img2);
//   }

//   List<Uint8List> getProfileImages(String assistantId) {
//     return box.get(assistantId) ?? [];
//   }

//   Future<void> clear() async {
//     await box.clear();
//   }
// }
