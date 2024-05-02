import 'package:ai_friend/features/profile/hobby/hobby_helper.dart';
import 'package:ai_friend/features/profile/hobby/hobby_storage.dart';
import 'package:flutter/material.dart';

class HobbyProvider extends ChangeNotifier {
  final HobbyStorage _hobbyStorage;

  HobbyProvider(this._hobbyStorage);

  List<String> get selectedHobby => _hobbyStorage.hobbies;

  List<HOBBY> hobby = [
    HOBBY.animals,
    HOBBY.artDesign,
    HOBBY.cooking,
    HOBBY.photography,
    HOBBY.sport,
    HOBBY.music,
    HOBBY.finance,
    HOBBY.literature,
    HOBBY.healthFitness,
    HOBBY.gardening,
    HOBBY.technology,
    HOBBY.career,
    HOBBY.science,
    HOBBY.travel,
    HOBBY.moviesShows,
    HOBBY.fashion,
    HOBBY.psychology,
    HOBBY.gadgets,
    HOBBY.ecology,
    HOBBY.cars,
    HOBBY.games,
  ];

  bool isSelected(HOBBY value) => selectedHobby.contains(value.toString());

  Future<void> toggleSelect(HOBBY value) async {
    if (isSelected(value)) {
      _hobbyStorage.removeHobby(value.toString());
    } else {
      _hobbyStorage.addHobby(value.toString());
    }
    notifyListeners();
  }
}
