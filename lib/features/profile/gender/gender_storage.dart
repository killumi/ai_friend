import 'dart:developer';
import 'package:hive/hive.dart';

class GenderStorage {
  static const storageName = 'gender';
  Box<String> get storage => Hive.box(storageName);
  String? get gender => storage.get('gender');

  static Future<void> openStorage() async {
    if (!Hive.isBoxOpen(storageName)) {
      log('OPEN GenderStorage');
      await Hive.openBox<String>(storageName);
    }
  }

  Future<void> saveGender(String val) async {
    await storage.put('gender', val);
  }

  Future<void> clear() async {
    await storage.clear();
  }
}
