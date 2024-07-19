import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
// import 'package:rate_my_app/rate_my_app.dart';

class RateAppHelper {
  // static final RateMyApp rateMyApp = RateMyApp(
  //   preferencesPrefix: 'rateMyApp_',
  //   minLaunches: 1,
  //   appStoreIdentifier: '6480462813',
  //   googlePlayIdentifier: '',
  // );

  // static Future<void> initPlagin() async {
  //   await rateMyApp.init();
  // }

  // static void showDialog(BuildContext context) async {
  //   await rateMyApp.showStarRateDialog(context);
  // }
}

class RateAppStorage {
  static const name = 'rateus';
  Box<bool> get box => Hive.box(name);
  bool get show => box.get('showAlertAfterVideoMessage') ?? true;

  static openStorage() async {
    if (!Hive.isBoxOpen(name)) {
      await Hive.openBox<bool>(name);
    }
  }

  Future<void> hide() async {
    await box.put('showAlertAfterVideoMessage', false);
  }

  Future<void> clear() async {
    await box.clear();
  }
}
