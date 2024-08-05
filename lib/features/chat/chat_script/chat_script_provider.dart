import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';
import 'package:ai_friend/domain/firebase/fire_database.dart';
import 'package:ai_friend/features/assistants/assistants_provider.dart';
import 'package:ai_friend/domain/entity/i_script_day/i_script_day.dart';
import 'package:ai_friend/domain/entity/i_script_message_data/i_script_message_data.dart';
import 'package:flutter/material.dart';

class ChatScriptProvider extends ChangeNotifier {
  final AssistantsProvider _assistantsProvider;
  final FireDatabase _database;

  IScriptDay? day;
  List<IScriptDay> assistantScript = [];
  bool _isScriptBoxExpanded = false;

  IAssistant get currentAssistant => _assistantsProvider.currentAssistant!;
  // current int index day and message
  int get currentDayNumber => currentAssistant.scriptDayIndex!;
  int get currentMessageNumber => currentAssistant.scriptMessageIndex!;

  //days
  int get scriptLength => assistantScript.length;
  //
  bool get isShowScriptWidgets => day != null;
  bool get isScriptBoxExpanded => _isScriptBoxExpanded;
  // показ баннера после 3 сообщения
  bool get showPremiumBanner =>
      currentDayNumber == 0 && currentMessageNumber >= 3;
  //  current message
  IScriptMessageData? get message {
    return day == null ? null : day?.data[currentMessageNumber];
  }

  ChatScriptProvider(this._assistantsProvider, this._database);

  Future<void> initScript() async {
    assistantScript = [];
    day = null;
    expandScriptBox(false);

    try {
      assistantScript = await _database.getScript(currentAssistant.id);
      if (assistantScript.isEmpty) return;
      if (currentDayNumber > assistantScript.length - 1) {
        day = null;
      } else {
        day = assistantScript[currentDayNumber];
        expandScriptBox(true);
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();
  }

  Future<void> showNextMessage() async {
    if (day == null) return;
    if (currentMessageNumber == day!.data.length - 1) {
      showNextDay();
      return;
    }
    final messageIndex = currentMessageNumber + 1;
    await saveScriptPosition(message: messageIndex);
  }

  Future<void> showNextDay() async {
    final dayIndex = currentDayNumber + 1;
    const messageIndex = 0;

    if (currentDayNumber == scriptLength - 1) {
      day = null;
      await saveScriptPosition(day: dayIndex, message: messageIndex);
      return;
    }

    await saveScriptPosition(day: dayIndex, message: messageIndex);
    day = assistantScript[currentDayNumber];
    notifyListeners();
  }

  Future<void> saveScriptPosition({int? day, int? message}) async {
    if (day == null && message == null) return;

    if (day != null) {
      currentAssistant.scriptDayIndex = day;
    }

    if (message != null) {
      currentAssistant.scriptMessageIndex = message;
    }

    await currentAssistant.save();
    notifyListeners();
  }

  void toggleShowScriptBox() {
    _isScriptBoxExpanded = !_isScriptBoxExpanded;
    notifyListeners();
  }

  void expandScriptBox(bool show) {
    _isScriptBoxExpanded = show;
    notifyListeners();
  }
}
