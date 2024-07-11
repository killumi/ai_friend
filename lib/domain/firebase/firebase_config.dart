import 'dart:convert';
import 'package:ai_friend/domain/entity/i_script_day/i_script_day.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseConfig {
  final FirebaseRemoteConfig config = FirebaseRemoteConfig.instance;
  // FirebaseConfig();

  int get dayLength => config.getAll().length - 4;
  bool get showMedia => config.getBool('showMedia');
  String get gptKey => config.getString('gptKey');
  String get gptBotId => config.getString('gptBotId');

  Future<void> init() async {
    await config.fetchAndActivate();
    // config.onConfigUpdated.listen((event) async {
    //   await config.fetch();
    // });
  }

  Future<IScriptDay?> getDailyChatScript(int dayNumber) async {
    await config.fetch();
    if (dayNumber > dayLength) return null;
    final value = config.getValue('day_$dayNumber');
    final decoded = jsonDecode(value.asString());
    final data = IScriptDay.fromMap(decoded);
    return data;
  }
}
