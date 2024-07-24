import 'package:apphud/apphud.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationService {
  static final FirebaseMessaging instance = FirebaseMessaging.instance;

  static Future<void> initFirebaseMessaging() async {
    instance.requestPermission();
    await instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> initOneSignal() async {
    const appId = "d2fbc13d-e3aa-4e16-8174-1368f91d3b40";
    OneSignal.initialize(appId);
    final userId = await Apphud.userID();
    await OneSignal.login(userId);
  }
}
