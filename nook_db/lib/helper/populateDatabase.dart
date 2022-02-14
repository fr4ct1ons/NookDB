import 'package:nook_db/structs.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getMusic() async
{
    const dataUrl = "http://acnhapi.com/v1/songs/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;
    var tempI = temp.entries.map((e) => e.value).toList();

    for (var i = 0; i < tempI.length; i++) {
      Music newMusic = Music();

      newMusic.usName = tempI[i]['name']['name-USen'];
      newMusic.imageUrl = tempI[i]['image_uri'];
      newMusic.buyPrice = tempI[i]['buy-price'] ?? -1;
      newMusic.sellPrice = tempI[i]['sell-price'];
      newMusic.isOrderable = tempI[i]['isOrderable'];
      newMusic.musicUrl = tempI[i]['music_uri'];

      newMusic.imageUrl = newMusic.imageUrl.replaceFirst(RegExp(r's'), '');

      musics.add(newMusic);
    }
}

Future<void> getVillagers() async {
    const dataUrl = "http://acnhapi.com/v1/villagers/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    //print("Item: ${tempI[0]}");

    for (var i = 0; i < tempI.length; i++) {
      Villager newVillager = Villager();

      newVillager.usName = tempI[i]['name']['name-USen'];
      newVillager.imageUrl = tempI[i]['image_uri'];
      newVillager.birthdayDate = tempI[i]['birthday'];
      newVillager.birthdayName = tempI[i]['birthday-string'];
      newVillager.catchphrase = tempI[i]['catch-phrase'];
      newVillager.gender = tempI[i]['gender'];
      newVillager.iconUrl = tempI[i]['icon_uri'];
      newVillager.personality = tempI[i]['personality'];
      newVillager.species = tempI[i]['species'];

      newVillager.iconUrl = newVillager.iconUrl.replaceFirst(RegExp(r's'), '');
      newVillager.imageUrl = newVillager.imageUrl.replaceFirst(RegExp(r's'), '');

      villagers.add(newVillager);
    }
  }

  Future<void> getFossils() async {
    const dataUrl = "https://acnhapi.com/v1/fossils/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    //print("Item: ${tempI[0]}");

    for (var i = 0; i < tempI.length; i++) {
      Fossil newFossil = Fossil();

      newFossil.usName = tempI[i]['name']['name-USen'];
      newFossil.imageUrl = tempI[i]['image_uri'];
      newFossil.price = tempI[i]['price'];
      newFossil.museumPhrase = tempI[i]['museum-phrase'];

      newFossil.imageUrl = newFossil.imageUrl.replaceFirst(RegExp(r's'), '');

      fossils.add(newFossil);
    }
  }

  Future<void> getArt() async {
    const dataUrl = "http://acnhapi.com/v1/art/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    //print("Item: ${tempI[0]}");

    for (var i = 0; i < tempI.length; i++) {
      Art newItem = Art();

      newItem.usName = tempI[i]['name']['name-USen'];
      newItem.buyPrice = tempI[i]['buy-price'] ?? -1;
      newItem.imageUrl = tempI[i]['image_uri'];
      newItem.hasFake = tempI[i]['hasFake'];
      newItem.sellPrice = tempI[i]['sell-price'] ?? -1;
      newItem.museumDesc = tempI[i]['museum-desc'];

      newItem.imageUrl = newItem.imageUrl.replaceFirst(RegExp(r's'), '');

      artPieces.add(newItem);
    }
  }

  Future<void> getItems() async {
    const dataUrl = "http://acnhapi.com/v1/houseware/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    //print("Item: ${tempI[0][0]['source-detail']}");

    for (var i = 0; i < tempI.length; i++) {
      Item newItem = Item();

      newItem.usName = tempI[i][0]['name']['name-USen'];
      newItem.bodyCustomizable = tempI[i][0]['canCustomizeBody'];
      newItem.buyPrice = tempI[i][0]['buy-price'] ?? -1;
      newItem.imageUrl = tempI[i][0]['image_uri'];
      newItem.isCatalog = tempI[i][0]['isCatalog'];
      newItem.isDiy = tempI[i][0]['isDIY'];
      newItem.patternCustomizable = tempI[i][0]['canCustomizePattern'];
      newItem.sellPrice = tempI[i][0]['sell-price'] ?? -1;
      newItem.size = tempI[i][0]['size'];
      newItem.source = tempI[i][0]['source'];
      newItem.sourceDetail = tempI[i][0]['source-detail'];

      newItem.imageUrl = newItem.imageUrl.replaceFirst(RegExp(r's'), '');

      items.add(newItem);
    }
  }

  Future<void> getItemsWall() async {
    const dataUrl = "http://acnhapi.com/v1/wallmounted/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    //print("Item: ${tempI[0][0]['source-detail']}");

    for (var i = 0; i < tempI.length; i++) {
      Item newItem = Item();

      newItem.usName = tempI[i][0]['name']['name-USen'];
      newItem.bodyCustomizable = tempI[i][0]['canCustomizeBody'];
      newItem.buyPrice = tempI[i][0]['buy-price'] ?? -1;
      newItem.imageUrl = tempI[i][0]['image_uri'];
      newItem.isCatalog = tempI[i][0]['isCatalog'];
      newItem.isDiy = tempI[i][0]['isDIY'];
      newItem.patternCustomizable = tempI[i][0]['canCustomizePattern'];
      newItem.sellPrice = tempI[i][0]['sell-price'] ?? -1;
      newItem.size = tempI[i][0]['size'];
      newItem.source = tempI[i][0]['source'];
      newItem.sourceDetail = tempI[i][0]['source-detail'];

      newItem.imageUrl = newItem.imageUrl.replaceFirst(RegExp(r's'), '');

      items.add(newItem);
    }
  }

  Future<void> getItemsMisc() async {
    const dataUrl = "http://acnhapi.com/v1/misc/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    //print("Item: ${tempI[0][0]['source-detail']}");

    for (var i = 0; i < tempI.length; i++) {
      Item newItem = Item();

      newItem.usName = tempI[i][0]['name']['name-USen'];
      newItem.bodyCustomizable = tempI[i][0]['canCustomizeBody'];
      newItem.buyPrice = tempI[i][0]['buy-price'] ?? -1;
      newItem.imageUrl = tempI[i][0]['image_uri'];
      newItem.isCatalog = tempI[i][0]['isCatalog'];
      newItem.isDiy = tempI[i][0]['isDIY'];
      newItem.patternCustomizable = tempI[i][0]['canCustomizePattern'];
      newItem.sellPrice = tempI[i][0]['sell-price'] ?? -1;
      newItem.size = tempI[i][0]['size'];
      newItem.source = tempI[i][0]['source'];
      newItem.sourceDetail = tempI[i][0]['source-detail'];

      newItem.imageUrl = newItem.imageUrl.replaceFirst(RegExp(r's'), '');

      items.add(newItem);
    }
  }

//Critters

  var _fish = <dynamic>[];
  var _bugs = <dynamic>[];
  var _crts = <dynamic>[];

  Future<void> getSeaCreatures() async {
    //var fish = <dynamic>[];
    const dataUrl = "http://acnhapi.com/v1/sea/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    _crts = temp.entries.map((e) => e.value).toList();

    //setState(() {
      for (var i = 0; i < _crts.length; i++) {
        Creature newCritter = Creature();
        newCritter.id = i;
        newCritter.usName = _crts[i]['name']['name-USen'];
        newCritter.monthArrayNorth =
            _crts[i]["availability"]["month-array-northern"].cast<int>();
        ;
        newCritter.monthArraySouth =
            _crts[i]["availability"]["month-array-southern"].cast<int>();
        ;
        newCritter.timeArray =
            _crts[i]['availability']['time-array'].cast<int>();
        ;
        newCritter.time = _crts[i]['availability']['time'];
        newCritter.isAllDay = _crts[i]['availability']['isAllDay'];
        newCritter.isAllYear = _crts[i]['availability']['isAllYear'];
        newCritter.iconUrl = _crts[i]['icon_uri'];
        newCritter.imageUrl = _crts[i]['image_uri'];
        newCritter.price = _crts[i]['price'];
        newCritter.catchPhrase = _crts[i]['catch-phrase'];
        newCritter.museumPhrase = _crts[i]['museum-phrase'];

        newCritter.imageUrl = newCritter.imageUrl.replaceFirst(RegExp(r's'), '');
        newCritter.iconUrl = newCritter.iconUrl.replaceFirst(RegExp(r's'), '');

        //newCritter.location = fish[i]['availability']["location"]; //Sea Creatures don't use location
        newCritter.speed = _crts[i]['speed'];
        newCritter.shadow = _crts[i]['shadow'];
        critters.add(newCritter);
      }
    //});
  }

  Future<void> getFish() async {
    //var fish = <dynamic>[];
    const dataUrl = "http://acnhapi.com/v1/fish/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    _fish = temp.entries.map((e) => e.value).toList();

    //setState(() {
      for (var i = 0; i < _fish.length; i++) {
        Fish newFish = Fish();
        newFish.id = i;
        newFish.usName = _fish[i]['name']['name-USen'];
        newFish.monthArrayNorth =
            _fish[i]["availability"]["month-array-northern"].cast<int>();
        ;
        newFish.monthArraySouth =
            _fish[i]["availability"]["month-array-southern"].cast<int>();
        ;
        newFish.timeArray = _fish[i]['availability']['time-array'].cast<int>();
        ;
        newFish.time = _fish[i]['availability']['time'];
        newFish.isAllDay = _fish[i]['availability']['isAllDay'];
        newFish.isAllYear = _fish[i]['availability']['isAllYear'];
        newFish.iconUrl = _fish[i]['icon_uri'];
        newFish.imageUrl = _fish[i]['image_uri'];
        newFish.price = _fish[i]['price'];
        newFish.catchPhrase = _fish[i]['catch-phrase'];
        newFish.museumPhrase = _fish[i]['museum-phrase'];

        newFish.imageUrl = newFish.imageUrl.replaceFirst(RegExp(r's'), '');
        newFish.iconUrl = newFish.iconUrl.replaceFirst(RegExp(r's'), '');

        newFish.priceCj = _fish[i]['price-cj'];
        newFish.shadow = _fish[i]['shadow'];
        newFish.location = _fish[i]['availability']["location"];
        newFish.rarity = _fish[i]['availability']["rarity"];

        critters.add(newFish);
      }
    //});
  }

  Future<void> getBugs() async {
    const dataUrl = "http://acnhapi.com/v1/bugs/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    _bugs = temp.entries.map((e) => e.value).toList();

    //setState(() {
      for (var i = 0; i < _bugs.length; i++) {
        Bug newCritter = Bug();
        newCritter.id = i;
        newCritter.usName = _bugs[i]['name']['name-USen'];
        newCritter.monthArrayNorth =
            _bugs[i]["availability"]["month-array-northern"].cast<int>();
        newCritter.monthArraySouth =
            _bugs[i]["availability"]["month-array-southern"].cast<int>();
        ;
        newCritter.timeArray =
            _bugs[i]['availability']['time-array'].cast<int>();
        newCritter.time = _bugs[i]['availability']['time'];
        newCritter.isAllDay = _bugs[i]['availability']['isAllDay'];
        newCritter.isAllYear = _bugs[i]['availability']['isAllYear'];
        newCritter.iconUrl = _bugs[i]['icon_uri'];
        newCritter.imageUrl = _bugs[i]['image_uri'];
        newCritter.price = _bugs[i]['price'];
        newCritter.catchPhrase = _bugs[i]['catch-phrase'];
        newCritter.museumPhrase = _bugs[i]['museum-phrase'];

        newCritter.imageUrl = newCritter.imageUrl.replaceFirst(RegExp(r's'), '');
        newCritter.iconUrl = newCritter.iconUrl.replaceFirst(RegExp(r's'), '');

        newCritter.priceFlick = _bugs[i]['price-flick'];
        newCritter.location = _bugs[i]['availability']["location"];
        newCritter.rarity = _bugs[i]['availability']["rarity"];

        critters.add(newCritter);
      }
    //});
  }