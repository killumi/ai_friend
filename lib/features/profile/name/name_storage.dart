import 'dart:developer';
import 'package:hive/hive.dart';

class NameStorage {
  static const storageName = 'name';
  Box<String> get storage => Hive.box(storageName);
  String get name => storage.get('name') ?? '';

  static Future<void> openStorage() async {
    if (!Hive.isBoxOpen(storageName)) {
      log('OPEN NameStorage');
      await Hive.openBox<String>(storageName);
    }
  }

  Future<void> saveName(String val) async {
    await storage.put('name', val);
  }

  Future<void> clear() async {
    await storage.clear();
  }
}
