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
  bool showEndDayUI = false;

  late IScriptDay? dailyScript;
  bool unlockTextField = false;

  // current int index day and message
  int get currentDayNumber => _storage.currentDay;
  int get currentMessageNumber => _storage.currentMessage;

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

  int get allDaysLenght => _config.dayLength;

  ChatScriptProvider(this._config, this._storage);

  Future<void> initScript() async {
    // print('allDaysLenght: $allDaysLenght');
    dailyScript = await _config.getDailyChatScript(currentDayNumber);

    // print('dailyScript___: $dailyScript');
    if (daylyScriptIsEnd && currentDayNumber == allDaysLenght) {
      dailyScript = null;
      showEndDayUI = false;
    }

    if (!locator<PaymentProvider>().isHasPremium &&
        daylyScriptIsEnd &&
        currentDayNumber != allDaysLenght) {
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
      // log('NEED SHOW PREMIUM SCREEN TO SHOW NEX DAY SCRIPT');
      if (allDaysLenght == currentDayNumber ||
          locator<PaymentProvider>().isHasPremium) {
        showEndDayUI = false;
      } else {
        showEndDayUI = true;
      }
      showNextDay();

      notifyListeners();
      return;
    }

    // print('currentMessageNumber: $currentMessageNumber');
    await _storage.setCurrentMessage(currentMessageNumber + 1);
    // print('currentMessageNumber2: $currentMessageNumber');
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
