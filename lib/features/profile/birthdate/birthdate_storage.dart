import 'dart:developer';
import 'package:hive/hive.dart';

class BirthDateStorage {
  static const storageName = 'birthdate';
  Box<DateTime> get storage => Hive.box(storageName);
  DateTime get birthdate =>
      storage.get('birthdate') ??
      DateTime(
        DateTime.now().year - 18,
        DateTime.now().month,
        DateTime.now().day,
      );

  static Future<void> openStorage() async {
    if (!Hive.isBoxOpen(storageName)) {
      log('OPEN BirthDateStorage');
      await Hive.openBox<DateTime>(storageName);
    }
  }

  Future<void> saveBirthDate(DateTime val) async {
    await storage.put('birthdate', val);
  }

  Future<void> clear() async {
    await storage.clear();
  }
}
