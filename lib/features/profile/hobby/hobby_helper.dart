// ignore_for_file: unnecessary_this
import 'package:ai_friend/features/profile/hobby/hobby_item.dart';
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
  intellectual,
  friendly,
  height,
  // new
  sincere,
  hiking,
  painting,
  supportive,
  creative,
}

extension HobbyAssistantHelper on String {
  Widget getFakeHobbyItem() {
    final isHeight = this.contains('height');
    if (isHeight) {
      const hobby = HOBBY.height;
      final icon = hobby.getHobbyIcon();
      final splitted = this.split('.');
      final title = "${splitted[1]}’${splitted[2]}”";
      return FakeHobbyItem(title: title, icon: icon);
    }

    switch (this) {
      case 'sincere':
        const hobby = HOBBY.sincere;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'animals':
        const hobby = HOBBY.animals;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'artDesign':
        const hobby = HOBBY.artDesign;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'cooking':
        const hobby = HOBBY.cooking;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'photography':
        const hobby = HOBBY.photography;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'sport':
        const hobby = HOBBY.sport;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'music':
        const hobby = HOBBY.music;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'finance':
        const hobby = HOBBY.finance;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'literature':
        const hobby = HOBBY.literature;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'healthFitness':
        const hobby = HOBBY.healthFitness;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'gardening':
        const hobby = HOBBY.gardening;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'technology':
        const hobby = HOBBY.technology;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'career':
        const hobby = HOBBY.career;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'science':
        const hobby = HOBBY.science;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'travel':
        const hobby = HOBBY.travel;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'moviesShows':
        const hobby = HOBBY.moviesShows;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'fashion':
        const hobby = HOBBY.sincere;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'psychology':
        const hobby = HOBBY.psychology;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'gadgets':
        const hobby = HOBBY.gadgets;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'ecology':
        const hobby = HOBBY.ecology;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'cars':
        const hobby = HOBBY.cars;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'games':
        const hobby = HOBBY.games;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'intellectual':
        const hobby = HOBBY.intellectual;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'friendly':
        const hobby = HOBBY.friendly;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'hiking':
        const hobby = HOBBY.hiking;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'painting':
        const hobby = HOBBY.painting;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'supportive':
        const hobby = HOBBY.supportive;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      case 'creative':
        const hobby = HOBBY.creative;
        final icon = hobby.getHobbyIcon();
        final title = hobby.getHobbyTitle();
        return FakeHobbyItem(title: title, icon: icon);
      default:
        return FakeHobbyItem(
          title: HOBBY.creative.getHobbyTitle(),
          icon: HOBBY.creative.getHobbyIcon(),
        );
    }
  }
}

extension HobbyHelper on HOBBY {
  String getHobbyTitle() {
    switch (this) {
      case HOBBY.sincere:
        return 'Sincere';
      case HOBBY.hiking:
        return 'Hiking';
      case HOBBY.painting:
        return 'Painting';
      case HOBBY.supportive:
        return 'Supportive';
      case HOBBY.creative:
        return 'Creative';
      // OLD
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
      case HOBBY.intellectual:
        return 'Intellectual';
      case HOBBY.friendly:
        return 'Friendly';
      case HOBBY.height:
        return "5’7”";
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

      case HOBBY.height:
        return Assets.coloredIcons.heightIcon.image(width: 20);

      case HOBBY.intellectual:
        return Assets.coloredIcons.intellectualIcon.image(width: 20);

      case HOBBY.friendly:
        return Assets.coloredIcons.friendlyIcon.image(width: 20);

      case HOBBY.sincere:
        return Assets.coloredIcons.sincereIcon.image(width: 20);

      case HOBBY.hiking:
        return Assets.coloredIcons.hikingIcon.image(width: 20);

      case HOBBY.painting:
        return Assets.coloredIcons.paintingIcon.image(width: 20);

      case HOBBY.creative:
        return Assets.coloredIcons.creativeIcon.image(width: 20);

      case HOBBY.supportive:
        return Assets.coloredIcons.supportiveIcon.image(width: 20);

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
      // new
      case 'HOBBY.sincere':
        return HOBBY.sincere;
      case 'HOBBY.hiking':
        return HOBBY.hiking;
      case 'HOBBY.painting':
        return HOBBY.painting;
      case 'HOBBY.supportive':
        return HOBBY.supportive;
      case 'HOBBY.creative':
        return HOBBY.creative;
      default:
        return HOBBY.animals;
    }
  }
}
