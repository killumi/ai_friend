import 'dart:developer';
import 'package:ai_friend/features/chat/chat_script/chat_script_storage.dart';
import 'package:ai_friend/domain/entity/i_script_day/i_script_day.dart';
import 'package:ai_friend/domain/entity/i_script_message_data/i_script_message_data.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/locator.dart';
import 'package:flutter/material.dart';

class ChatScriptProvider extends ChangeNotifier {
  final FirebaseConfig _config;
  final ChatScriptStorage _storage;
  bool _isShowScriptBox = false;

  late IScriptDay? dailyScript;
  bool unlockTextField = false;

  int get currentDayNumber => _storage.currentDay;
  int get currentMessageNumber => _storage.currentMessage;

  IScriptMessageData? get scriptMessage =>
      dailyScript?.data[currentMessageNumber];

  bool get isShowScriptBox => _isShowScriptBox;
  bool get isShowRollUpBoxButton => dailyScript != null;

  bool get daylyScriptIsEnd => currentMessageNumber == dailyScript!.data.length;

  bool get textfieldAvailable => scriptMessage?.textfieldAvailable ?? false;

  bool get needShowPremiumBanner =>
      currentDayNumber == 1 && currentMessageNumber == 3;

  ChatScriptProvider(this._config, this._storage);

  Future<void> initScript() async {
    dailyScript = await _config.getDailyChatScript(currentDayNumber);
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
      // if()
      showNextDay();
      // await _storage.setCurrentDay(currentDayNumber + 1);
      // dailyScript = await _config.getDailyChatScript(currentDayNumber);
      // notifyListeners();
      // await _storage.setCurrentMessage(0);
      // notifyListeners();
      return;
    }

    // if()
    await _storage.setCurrentMessage(currentMessageNumber + 1);
    notifyListeners();
  }

  Future<void> showPrevMessage() async {
    if (currentMessageNumber == 0) {
      if (currentDayNumber > 1) {
        await _storage.setCurrentDay(currentDayNumber - 1);
        dailyScript = await _config.getDailyChatScript(currentDayNumber);
        await _storage.setCurrentMessage(dailyScript!.data.length - 1);
      }
      notifyListeners();
      return;
    }
    await _storage.setCurrentMessage(currentMessageNumber - 1);
    notifyListeners();
  }

  Future<void> showPrevDay() async {
    if (dailyScript == null) {
      await _storage.setCurrentDay(_config.dayLength);
      dailyScript = await _config.getDailyChatScript(currentDayNumber);
      await _storage.setCurrentMessage(dailyScript!.data.length - 1);
      notifyListeners();
      return;
    }
    if (currentDayNumber > 1) {
      await _storage.setCurrentDay(currentDayNumber - 1);
      dailyScript = await _config.getDailyChatScript(currentDayNumber);
      await _storage.setCurrentMessage(dailyScript!.data.length - 1);
    }

    notifyListeners();
  }

  Future<void> showNextDay() async {
    if (currentDayNumber == _config.dayLength) {
      dailyScript = null;
      notifyListeners();
      return;
    }
    await _storage.setCurrentDay(currentDayNumber + 1);
    dailyScript = await _config.getDailyChatScript(currentDayNumber);
    notifyListeners();
    await _storage.setCurrentMessage(0);
    notifyListeners();
  }

  Future<void> restart() async {
    unlock(false);
    await _storage.setCurrentDay(1);
    dailyScript = await _config.getDailyChatScript(currentDayNumber);
    await _storage.setCurrentMessage(0);
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
