List<Critter> critters = [];

class Critter {
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
    if (monthArrayNorth.contains(DateTime.now().month)) {
      if (timeArray.contains(DateTime.now().hour)) {
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
