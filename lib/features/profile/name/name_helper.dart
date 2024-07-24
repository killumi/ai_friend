import 'package:ai_friend/domain/services/locator.dart';
import 'package:ai_friend/features/profile/name/name_storage.dart';

extension NameHelper on String {
  String replaceUserName() {
    final storage = locator<NameStorage>();
    String name = storage.name;
    String modifiedString = replaceFirst('{name}', name);
    return modifiedString;
  }
}
