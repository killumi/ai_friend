import 'dart:developer';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class TrackingHelper {
  static Future<void> requestTrackingAuthorization() async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  }
}
