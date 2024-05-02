import 'package:ai_friend/features/profile/birthdate/birthdate_storage.dart';
import 'package:ai_friend/features/profile/gender/gender_storage.dart';
import 'package:ai_friend/features/profile/name/name_storage.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final NameStorage _nameStorage;
  final GenderStorage _genderStorage;
  final BirthDateStorage _birthDateStorage;

  ProfileProvider(
    this._birthDateStorage,
    this._genderStorage,
    this._nameStorage,
  );

  final _nameTextController = TextEditingController();
  String name = '';
  String gender = '';
  late DateTime birhtDate;
  bool isDisabled = true;

  TextEditingController get nameTextController => _nameTextController;

  Future<void> init() async {
    birhtDate = _birthDateStorage.birthdate;
    name = _nameStorage.name;
    _nameTextController.text = name;
    gender = _genderStorage.gender ?? 'Male';

    if (name.isEmpty) {
      isDisabled = true;
    } else {
      isDisabled = false;
    }
  }

  void onChangeName(String val) {
    final name = val.trim();

    if (name.isEmpty) {
      isDisabled = true;
    } else {
      isDisabled = false;
    }

    notifyListeners();
  }

  void onChangeGender(String val) {
    gender = val;
    notifyListeners();
  }

  void onChangeBirthDate(DateTime val) {
    birhtDate = val;
  }

  Future<void> onSaveProfile() async {
    await _nameStorage.saveName(_nameTextController.text.trim());
    await _genderStorage.saveGender(gender);
    await _birthDateStorage.saveBirthDate(birhtDate);
  }
}
