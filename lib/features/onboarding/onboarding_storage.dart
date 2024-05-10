// import 'dart:developer';
import 'package:hive/hive.dart';

class OnboardingStorage {
  static const storageName = 'onboarding';
  Box<bool> get storage => Hive.box(storageName);
  bool get wasShown => storage.get('wasShown') ?? false;

  static Future<void> openStorage() async {
    if (!Hive.isBoxOpen(storageName)) {
      await Hive.openBox<bool>(storageName);
    }
  }

  Future<void> hideToNextLaunch() async {
    await storage.put('wasShown', true);
  }

  Future<void> clear() async {
    await storage.clear();
  }
}
