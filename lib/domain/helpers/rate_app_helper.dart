import 'package:flutter/cupertino.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppHelper {
  static final RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minLaunches: 1,
    appStoreIdentifier: '6480462813',
    googlePlayIdentifier: '',
  );

  static Future<void> initPlagin() async {
    await rateMyApp.init();
  }

  static void showDialog(BuildContext context) async {
    await rateMyApp.showStarRateDialog(context);
  }
}
