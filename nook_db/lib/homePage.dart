import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nook_db/availableCritters.dart';
import 'package:nook_db/buttonGrid.dart';
import 'package:nook_db/structs.dart';
import 'todoList.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'Villager';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getItems();
    _getItemsWall();
    _getItemsMisc();
    _getArt();
    _getFossils();
    _getVillagers();
  }

  void _getVillagers() async {
    const dataUrl = "http://acnhapi.com/v1/villagers/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    print("Item: ${tempI[0]}");

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

  void _getFossils() async {
    const dataUrl = "https://acnhapi.com/v1/fossils/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    print("Item: ${tempI[0]}");

    for (var i = 0; i < tempI.length; i++) {
      Fossil newFossil = Fossil();

      newFossil.usName = tempI[i]['name']['name-USen'];
      newFossil.imageUrl = tempI[i]['image_uri'];
      newFossil.price = tempI[i]['price'];
      newFossil.museumPhrase = tempI[i]['museum-phrase'];

      fossils.add(newFossil);
    }
  }

  void _getArt() async {
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

  void _getItems() async {
    const dataUrl = "http://acnhapi.com/v1/houseware/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    print("Item: ${tempI[0][0]['source-detail']}");

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

  void _getItemsWall() async {
    const dataUrl = "http://acnhapi.com/v1/wallmounted/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    print("Item: ${tempI[0][0]['source-detail']}");

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

  void _getItemsMisc() async {
    const dataUrl = "http://acnhapi.com/v1/misc/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    var tempI = temp.entries.map((e) => e.value).toList();

    print("Item: ${tempI[0][0]['source-detail']}");

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
          children: const <Widget>[
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
            AvailableCritters()
          ],
        ),
      ),
    );
  }
}
