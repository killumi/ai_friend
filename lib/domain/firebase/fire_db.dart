import 'dart:developer';
import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';
import 'package:ai_friend/domain/services/locator.dart';
import 'package:ai_friend/domain/storages/assistant_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabase {
  final _db = FirebaseFirestore.instance;

  Future<void> getAssistants() async {
    final data = await _db.collection("assistants").get();

    for (var doc in data.docs) {
      final profile = IAssistant.fromMap(doc.data());
      await locator<AssistantStorage>().update(profile);
      // log(profile.toString());
    }
  }
}
