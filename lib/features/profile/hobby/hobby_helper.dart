import 'package:ai_friend/gen/assets.gen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_image/flutter_image.dart';

enum HOBBY {
  animals,
  artDesign,
  cooking,
  photography,
  sport,
  music,
  finance,
  literature,
  healthFitness,
  gardening,
  technology,
  career,
  science,
  travel,
  moviesShows,
  fashion,
  psychology,
  gadgets,
  ecology,
  cars,
  games,
}

extension HobbyHelper on HOBBY {
  String getHobbyTitle() {
    switch (this) {
      case HOBBY.animals:
        return 'Animals';
      case HOBBY.artDesign:
        return 'Art & design';
      case HOBBY.cooking:
        return 'Cooking';
      case HOBBY.photography:
        return 'Photography';
      case HOBBY.sport:
        return 'Sport';
      case HOBBY.music:
        return 'Music';
      case HOBBY.finance:
        return 'Finance';
      case HOBBY.literature:
        return 'Literature';
      case HOBBY.healthFitness:
        return 'Health & Fitness';
      case HOBBY.gardening:
        return 'Gardening';
      case HOBBY.technology:
        return 'Technology';
      case HOBBY.career:
        return 'Career';
      case HOBBY.science:
        return 'Science';
      case HOBBY.travel:
        return 'Travel';
      case HOBBY.moviesShows:
        return 'Movies & TV Shows';
      case HOBBY.fashion:
        return 'Fashion';
      case HOBBY.psychology:
        return 'Psychology';
      case HOBBY.gadgets:
        return 'Gadgets';
      case HOBBY.ecology:
        return 'Ecology';
      case HOBBY.cars:
        return 'Cars';
      case HOBBY.games:
        return 'Games';
      default:
        return '';
    }
  }

  Image getHobbyIcon() {
    switch (this) {
      case HOBBY.animals:
        return Assets.coloredIcons.animalsIcon.image(width: 20);
      case HOBBY.artDesign:
        return Assets.coloredIcons.artIcon.image(width: 20);

      case HOBBY.cooking:
        return Assets.coloredIcons.cookingIcon.image(width: 20);

      case HOBBY.photography:
        return Assets.coloredIcons.photographyIcon.image(width: 20);

      case HOBBY.sport:
        return Assets.coloredIcons.sportsIcon.image(width: 20);

      case HOBBY.music:
        return Assets.coloredIcons.musicIcon.image(width: 20);

      case HOBBY.finance:
        return Assets.coloredIcons.financeIcon.image(width: 20);

      case HOBBY.literature:
        return Assets.coloredIcons.literatureIcon.image(width: 20);

      case HOBBY.healthFitness:
        return Assets.coloredIcons.healthIcon.image(width: 20);

      case HOBBY.gardening:
        return Assets.coloredIcons.gardeningIcon.image(width: 20);

      case HOBBY.technology:
        return Assets.coloredIcons.technologyIcon.image(width: 20);

      case HOBBY.career:
        return Assets.coloredIcons.careerIcon.image(width: 20);

      case HOBBY.science:
        return Assets.coloredIcons.scienceIcon.image(width: 20);

      case HOBBY.travel:
        return Assets.coloredIcons.travelIcon.image(width: 20);

      case HOBBY.moviesShows:
        return Assets.coloredIcons.moviesIcon.image(width: 20);

      case HOBBY.fashion:
        return Assets.coloredIcons.fashionIcon.image(width: 20);

      case HOBBY.psychology:
        return Assets.coloredIcons.psychologyIcon.image(width: 20);

      case HOBBY.gadgets:
        return Assets.coloredIcons.gadgetsIcon.image(width: 20);

      case HOBBY.ecology:
        return Assets.coloredIcons.ecologyIcon.image(width: 20);

      case HOBBY.cars:
        return Assets.coloredIcons.carsIcon.image(width: 20);

      case HOBBY.games:
        return Assets.coloredIcons.gamesIcon.image(width: 20);

      default:
        return Assets.coloredIcons.animalsIcon.image(width: 20);
    }
  }
}

extension HobbyStringHelper on String {
  HOBBY getHobby() {
    switch (this) {
      case 'HOBBY.animals':
        return HOBBY.animals;
      case 'HOBBY.artDesign':
        return HOBBY.artDesign;
      case 'HOBBY.cooking':
        return HOBBY.cooking;
      case 'HOBBY.photography':
        return HOBBY.photography;
      case 'HOBBY.sport':
        return HOBBY.sport;
      case 'HOBBY.music':
        return HOBBY.music;
      case 'HOBBY.finance':
        return HOBBY.finance;
      case 'HOBBY.literature':
        return HOBBY.literature;
      case 'HOBBY.healthFitness':
        return HOBBY.healthFitness;
      case 'HOBBY.gardening':
        return HOBBY.gardening;
      case 'HOBBY.technology':
        return HOBBY.technology;
      case 'HOBBY.career':
        return HOBBY.career;
      case 'HOBBY.science':
        return HOBBY.science;
      case 'HOBBY.travel':
        return HOBBY.travel;
      case 'HOBBY.moviesShows':
        return HOBBY.moviesShows;
      case 'HOBBY.fashion':
        return HOBBY.fashion;
      case 'HOBBY.psychology':
        return HOBBY.psychology;
      case 'HOBBY.gadgets':
        return HOBBY.gadgets;
      case 'HOBBY.ecology':
        return HOBBY.ecology;
      case 'HOBBY.cars':
        return HOBBY.cars;
      case 'HOBBY.games':
        return HOBBY.games;
      default:
        return HOBBY.animals;
    }
  }
}
