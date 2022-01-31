import 'package:path/path.dart';

List<Critter> critters = [];

bool isNorthernHemisphere = true;

class Critter {
  int id = 0;
  String usName = '';
  String time = '';
  List<int> timeArray = [];
  List<int> monthArrayNorth = [];
  List<int> monthArraySouth = [];
  bool isAllDay = false, isAllYear = false;
  int price = 0;
  String catchPhrase = '';
  String museumPhrase = '';
  String iconUrl = '';
  String imageUrl = '';
  String location = '';

  bool isActive() {
    if (timeArray.contains(DateTime.now().hour)) {
      if (monthArrayNorth.contains(DateTime.now().month) && isNorthernHemisphere) {
        return true;
      }
      else if(monthArraySouth.contains(DateTime.now().month) && !isNorthernHemisphere)
      {
        return true;
      }
    }

    return false;
  }

  String uppercaseName() {
    return usName[0].toUpperCase() + usName.substring(1);
  }
}

class Fish extends Critter {
  int priceCj = 0;
  String shadow = '';
  String rarity = '';
}

class Bug extends Critter {
  int priceFlick = 0;
  String rarity = '';
}

class Creature extends Critter {
  String speed = '';
  String shadow = '';
}

//ITEMS

List<Item> items = [];

class Item {
  String usName = '';
  String imageUrl = '';
  int buyPrice = 0;
  int sellPrice = 0;
  bool isDiy = false;
  String source = '', sourceDetail = '';
  String size = '';
  bool isCatalog = false;
  bool bodyCustomizable = false;
  bool patternCustomizable = false;

  String uppercaseName() {
    return usName[0].toUpperCase() + usName.substring(1);
  }
}

// ART

List<Art> artPieces = [];

class Art {
  String usName = '';
  bool hasFake = false;
  int buyPrice = -1;
  int sellPrice = -1;
  String imageUrl = '';
  String museumDesc = '';

  String uppercaseName() {
    return usName[0].toUpperCase() + usName.substring(1);
  }
}

//FOSSILS

List<Fossil> fossils = [];

class Fossil {
  String usName = '';
  int price = -1;
  String museumPhrase = '';
  String imageUrl = '';

  String uppercaseName() {
    return usName[0].toUpperCase() + usName.substring(1);
  }
}

List<Villager> villagers = [];

class Villager {
  String usName = '';
  String personality = '';
  String birthdayName = '', birthdayDate = '';
  String gender = '';
  String species = '';
  String catchphrase = '';
  String imageUrl = '';
  String iconUrl = '';

  String uppercaseName() {
    return usName[0].toUpperCase() + usName.substring(1);
  }
}
