import 'dart:convert';
import 'package:ai_friend/entity/i_script_day/i_script_day.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseConfig {
  final FirebaseRemoteConfig config = FirebaseRemoteConfig.instance;
  FirebaseConfig() {
    config.fetchAndActivate();
    config.onConfigUpdated.listen((event) {
      config.fetch();
    });
  }

  int get dayLength => config.getAll().length - 1;

  IScriptDay? getDailyChatScript(int dayNumber) {
    if (dayNumber > dayLength) return null;
    final value = config.getValue('day_$dayNumber');
    final decoded = jsonDecode(value.asString());
    final data = IScriptDay.fromMap(decoded);
    return data;
  }
}
