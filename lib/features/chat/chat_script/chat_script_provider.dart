import 'dart:developer';
import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';
import 'package:ai_friend/domain/firebase/fire_database.dart';
import 'package:ai_friend/features/assistants/assistants_provider.dart';
import 'package:ai_friend/domain/entity/i_script_day/i_script_day.dart';
import 'package:ai_friend/domain/entity/i_script_message_data/i_script_message_data.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/domain/services/locator.dart';
import 'package:flutter/material.dart';

class ChatScriptProvider extends ChangeNotifier {
  final AssistantsProvider _assistantsProvider;
  final FireDatabase _database;

  IScriptDay? dailyScript;
  List<IScriptDay> assistantScript = [];

  bool _isShowScriptBox = false;
  bool showEndDayUI = false;
  bool unlockTextField = false;

  IAssistant get currentAssistant => _assistantsProvider.currentAssistant!;

  // current int index day and message
  int get currentDayNumber => currentAssistant.scriptDayIndex!;
  int get currentMessageNumber => currentAssistant.scriptMessageIndex!;

  IScriptMessageData? get scriptMessage =>
      dailyScript?.data[currentMessageNumber];

  bool get isShowScriptBox => _isShowScriptBox;
  bool get isShowRollUpBoxButton => dailyScript != null;

  // bool get showEndDayUI => currentMessageNumber + 1 == dailyScript!.data.length;
  bool get daylyScriptIsEnd => dailyScript == null
      ? true
      : currentMessageNumber == dailyScript!.data.length - 1;

  bool get textfieldAvailable => scriptMessage?.textfieldAvailable ?? false;

  // показ баннера после 3 сообщения
  bool get needShowPremiumBanner =>
      currentDayNumber == 1 && currentMessageNumber == 3;

  // bool get isHasPremium => locator<PaymentProvider>().isHasPremium;

  int get assistantScriptLength => assistantScript.length;

  ChatScriptProvider(this._assistantsProvider, this._database);

  Future<void> initScript() async {
    assistantScript = [];
    notifyListeners();

    try {
      assistantScript = await _database.getScript(currentAssistant.id);

      if (currentDayNumber > assistantScript.length) {
        dailyScript = null;
      } else {
        dailyScript = assistantScript[currentDayNumber];
      }
      notifyListeners();
      assistantScript.forEach((day) {
        print('Day ID: ${day.id}, Messages: ${day.toString()}');
      });
    } catch (e) {
      print('Error: $e');
    }
    print('allDaysLenght: $assistantScriptLength');
    print('dailyScript___: $dailyScript');

    if (daylyScriptIsEnd && currentDayNumber == assistantScriptLength) {
      dailyScript = null;
      showEndDayUI = false;
    }

    if (!locator<PaymentProvider>().isHasPremium &&
        daylyScriptIsEnd &&
        currentDayNumber != assistantScriptLength) {
      showEndDayUI = true;
    }

    notifyListeners();
    // print('$dailyScript');
  }

  void unlock(bool val) {
    unlockTextField = val;
    notifyListeners();
  }

  void showCurrent() {
    log(currentDayNumber.toString());
    log(currentMessageNumber.toString());
  }

  Future<void> showNextMessage() async {
    if (daylyScriptIsEnd) {
      log('NEED SHOW PREMIUM SCREEN TO SHOW NEX DAY SCRIPT');
      if (assistantScriptLength == currentDayNumber ||
          locator<PaymentProvider>().isHasPremium) {
        showEndDayUI = false;
      } else {
        showEndDayUI = true;
      }
      showNextDay();
      notifyListeners();
      return;
    }

    print('currentMessageNumber1: $currentMessageNumber');
    currentAssistant.scriptMessageIndex = currentMessageNumber + 1;
    await currentAssistant.save();
    print('currentMessageNumber2: $currentMessageNumber');
    notifyListeners();
  }

  // Future<void> showPrevMessage() async {
  //   if (currentMessageNumber == 0) {
  //     if (currentDayNumber > 1) {
  //       await _storage.setCurrentDay(currentDayNumber - 1);
  //       dailyScript = await _config.getDailyChatScript(currentDayNumber);
  //       await _storage.setCurrentMessage(dailyScript!.data.length - 1);
  //     }
  //     notifyListeners();
  //     return;
  //   }
  //   await _storage.setCurrentMessage(currentMessageNumber - 1);
  //   notifyListeners();
  // }

  // Future<void> showPrevDay() async {
  //   if (dailyScript == null) {
  //     await _storage.setCurrentDay(_config.dayLength);
  //     dailyScript = await _config.getDailyChatScript(currentDayNumber);
  //     await _storage.setCurrentMessage(dailyScript!.data.length - 1);
  //     notifyListeners();
  //     return;
  //   }
  //   if (currentDayNumber > 1) {
  //     await _storage.setCurrentDay(currentDayNumber - 1);
  //     dailyScript = await _config.getDailyChatScript(currentDayNumber);
  //     await _storage.setCurrentMessage(dailyScript!.data.length - 1);
  //   }

  //   notifyListeners();
  // }

  Future<void> showNextDay() async {
    if (currentDayNumber == assistantScriptLength) {
      dailyScript = null;
      notifyListeners();
      return;
    }

    print('currentDayNumber 1: $currentDayNumber');
    currentAssistant.scriptDayIndex = currentDayNumber + 1;
    currentAssistant.scriptMessageIndex = 0;
    await currentAssistant.save();
    print('currentDayNumber 2: $currentDayNumber');
    dailyScript = assistantScript[currentDayNumber];
    notifyListeners();
  }

  void toggleShowScriptBox() {
    _isShowScriptBox = !_isShowScriptBox;
    notifyListeners();
  }

  void showScriptBox(bool show) {
    _isShowScriptBox = show;
    notifyListeners();
  }
}
