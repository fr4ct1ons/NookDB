import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nook_db/availableCritters.dart';
import 'package:nook_db/buttonGrid.dart';
import 'package:nook_db/structs.dart';
import 'todoList.dart';
import 'package:http/http.dart' as http;
import 'database.dart' as db;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'Villager';
  Widget availableCritters = Text("Loading critters...");

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();

    db.startDatabase().then((_) {
      //TODO: This is horrible, but flutter/dart async methods force my hand.
      db.getTracked().then((value) {
        //Getting everything
        _getBugs() //
            .then((value) => _getFish() //
                .then((value) => _getSeaCreatures().then((value) => _getItems()
                    .then((value) => _getItemsWall().then((value) =>
                        _getItemsMisc().then((value) => _getArt().then(
                            (value) => _getFossils()
                                .then((value) => _getVillagers().then((value) {
                                      print("done");
                                      setState(() {
                                        availableCritters = AvailableCritters();
                                      });
                                    })))))))));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text("NookDB"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            TodoList(),
            ButtonGrid(),
            SizedBox(
              height: 7,
            ),
            Text(
              "Available critters",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 7,
            ),
            availableCritters
          ],
        ),
      ),
    );
  }

  Future<void> _getVillagers() async {
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

      villagers.add(newVillager);
    }
  }

  Future<void> _getFossils() async {
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

      fossils.add(newFossil);
    }
  }

  Future<void> _getArt() async {
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

      artPieces.add(newItem);
    }
  }

  Future<void> _getItems() async {
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

      items.add(newItem);
    }
  }

  Future<void> _getItemsWall() async {
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

      items.add(newItem);
    }
  }

  Future<void> _getItemsMisc() async {
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

      items.add(newItem);
    }
  }

//Critters

  var fish = <dynamic>[];
  var bugs = <dynamic>[];
  var crts = <dynamic>[];

  Future<void> _getSeaCreatures() async {
    //var fish = <dynamic>[];
    const dataUrl = "http://acnhapi.com/v1/sea/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    crts = temp.entries.map((e) => e.value).toList();

    setState(() {
      for (var i = 0; i < crts.length; i++) {
        Creature newCritter = Creature();
        newCritter.id = i;
        newCritter.usName = crts[i]['name']['name-USen'];
        newCritter.monthArrayNorth =
            crts[i]["availability"]["month-array-northern"].cast<int>();
        ;
        newCritter.monthArraySouth =
            crts[i]["availability"]["month-array-southern"].cast<int>();
        ;
        newCritter.timeArray =
            crts[i]['availability']['time-array'].cast<int>();
        ;
        newCritter.time = crts[i]['availability']['time'];
        newCritter.isAllDay = crts[i]['availability']['isAllDay'];
        newCritter.isAllYear = crts[i]['availability']['isAllYear'];
        newCritter.iconUrl = crts[i]['icon_uri'];
        newCritter.imageUrl = crts[i]['image_uri'];
        newCritter.price = crts[i]['price'];
        newCritter.catchPhrase = crts[i]['catch-phrase'];
        newCritter.museumPhrase = crts[i]['museum-phrase'];

        //newCritter.location = fish[i]['availability']["location"]; //Sea Creatures don't use location
        newCritter.speed = crts[i]['speed'];
        newCritter.shadow = crts[i]['shadow'];
        critters.add(newCritter);
      }
    });
  }

  Future<void> _getFish() async {
    //var fish = <dynamic>[];
    const dataUrl = "http://acnhapi.com/v1/fish/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    fish = temp.entries.map((e) => e.value).toList();

    setState(() {
      for (var i = 0; i < fish.length; i++) {
        Fish newFish = Fish();
        newFish.id = i;
        newFish.usName = fish[i]['name']['name-USen'];
        newFish.monthArrayNorth =
            fish[i]["availability"]["month-array-northern"].cast<int>();
        ;
        newFish.monthArraySouth =
            fish[i]["availability"]["month-array-southern"].cast<int>();
        ;
        newFish.timeArray = fish[i]['availability']['time-array'].cast<int>();
        ;
        newFish.time = fish[i]['availability']['time'];
        newFish.isAllDay = fish[i]['availability']['isAllDay'];
        newFish.isAllYear = fish[i]['availability']['isAllYear'];
        newFish.iconUrl = fish[i]['icon_uri'];
        newFish.imageUrl = fish[i]['image_uri'];
        newFish.price = fish[i]['price'];
        newFish.catchPhrase = fish[i]['catch-phrase'];
        newFish.museumPhrase = fish[i]['museum-phrase'];

        newFish.priceCj = fish[i]['price-cj'];
        newFish.shadow = fish[i]['shadow'];
        newFish.location = fish[i]['availability']["location"];
        newFish.rarity = fish[i]['availability']["rarity"];

        critters.add(newFish);
      }
    });
  }

  Future<void> _getBugs() async {
    const dataUrl = "http://acnhapi.com/v1/bugs/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    bugs = temp.entries.map((e) => e.value).toList();

    setState(() {
      for (var i = 0; i < bugs.length; i++) {
        Bug newCritter = Bug();
        newCritter.id = i;
        newCritter.usName = bugs[i]['name']['name-USen'];
        newCritter.monthArrayNorth =
            bugs[i]["availability"]["month-array-northern"].cast<int>();
        newCritter.monthArraySouth =
            bugs[i]["availability"]["month-array-southern"].cast<int>();
        ;
        newCritter.timeArray =
            bugs[i]['availability']['time-array'].cast<int>();
        newCritter.time = bugs[i]['availability']['time'];
        newCritter.isAllDay = bugs[i]['availability']['isAllDay'];
        newCritter.isAllYear = bugs[i]['availability']['isAllYear'];
        newCritter.iconUrl = bugs[i]['icon_uri'];
        newCritter.imageUrl = bugs[i]['image_uri'];
        newCritter.price = bugs[i]['price'];
        newCritter.catchPhrase = bugs[i]['catch-phrase'];
        newCritter.museumPhrase = bugs[i]['museum-phrase'];

        newCritter.priceFlick = bugs[i]['price-flick'];
        newCritter.location = bugs[i]['availability']["location"];
        newCritter.rarity = bugs[i]['availability']["rarity"];

        critters.add(newCritter);
      }
    });
  }
}
