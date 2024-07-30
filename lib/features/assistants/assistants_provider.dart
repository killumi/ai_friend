import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/firebase/fire_database.dart';
import 'package:ai_friend/features/assistants/assistant_storage.dart';
import 'package:flutter/material.dart';

class AssistantsProvider extends ChangeNotifier {
  IAssistant? _currentAssistant;

  final FireDatabase _fireDatabase;
  final AssistantStorage _storage;

  List<IAssistant> get assistants =>
      _storage.profiles.where((e) => !e.hide!).toList();
  IAssistant? get currentAssistant => _currentAssistant;

  List<IChatMessage> get videos => _currentAssistant!.messages!
      .where((e) => e.type.contains('video'))
      .toList();
  List<IChatMessage> get images => _currentAssistant!.messages!
      .where((e) => e.type.contains('image'))
      .toList();

  AssistantsProvider(this._fireDatabase, this._storage);

  Future<void> updateAssistants() async {
    final profiles = await _fireDatabase.getAssistants();
    for (var e in profiles) {
      await _storage.update(e);
    }

    _currentAssistant = profiles.first;
  }

  void selectAssistant(IAssistant value) {
    _currentAssistant = value;
    notifyListeners();
  }
}
