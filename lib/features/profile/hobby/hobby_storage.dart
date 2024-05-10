import 'package:hive/hive.dart';

class HobbyStorage {
  static const storageName = 'hobbies';
  Box<String> get storage => Hive.box(storageName);
  List<String> get hobbies => storage.values.toList();

  static Future<void> openStorage() async {
    if (!Hive.isBoxOpen(storageName)) {
      await Hive.openBox<String>(storageName);
    }
  }

  Future<void> addHobby(String val) async {
    await storage.add(val);
  }

  Future<void> removeHobby(String val) async {
    final index = hobbies.indexOf(val);
    await storage.deleteAt(index);
  }

  Future<void> clear() async {
    await storage.clear();
  }
}
