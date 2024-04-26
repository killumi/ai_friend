extension NameHelper on String {
  String replaceUserName() {
    String name = 'PEDRO';
    String modifiedString = replaceFirst('{name}', name);
    return modifiedString;
  }
}
