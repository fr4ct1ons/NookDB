import 'package:flutter/material.dart';
import 'package:nook_db/bugView.dart';
import 'package:nook_db/fishView.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nook_db/seaCreatureView.dart';
import 'structs.dart';

class AvailableCritters extends StatefulWidget {
  const AvailableCritters({Key? key}) : super(key: key);

  @override
  _AvailableCrittersState createState() => _AvailableCrittersState();
}

class _AvailableCrittersState extends State<AvailableCritters> {
  List<Widget> _buttons = [];
  var fish = <dynamic>[];
  var bugs = <dynamic>[];
  var crts = <dynamic>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getCritters();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemCount: _buttons.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return _buttons[index];
        },
      ),
    );
  }

  void _showFish(Fish fish) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return FishView(
          fish: fish,
        );
      },
    ));
  }

  void _showCreature(Creature creature) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SeaCreatureView(
          creature: creature,
        );
      },
    ));
  }

  void _showBug(Bug bug) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return BugView(
          bug: bug,
        );
      },
    ));
  }

  void _getCritters() async {
    _getFish();
    _getBugs();
    _getSeaCreatures();
  }

  void _getSeaCreatures() async {
    //var fish = <dynamic>[];
    const dataUrl = "http://acnhapi.com/v1/sea/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    crts = temp.entries.map((e) => e.value).toList();

    print(
        "ACTUAL creature: ${crts[0]["availability"]["month-array-northern"]}");
    print('Current hour: ${DateTime.now().hour}');

    setState(() {
      for (var i = 0; i < crts.length; i++) {
        Creature newCritter = Creature();
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

        if ((crts[i]["availability"]["month-array-northern"] as List)
            .contains(DateTime.now().month)) {
          if ((crts[i]["availability"]["time-array"] as List)
              .contains(DateTime.now().hour)) {
            _buttons.add(RawMaterialButton(
              onPressed: () {
                _showCreature(newCritter);
              },
              elevation: 2.0,
              fillColor: Colors.deepPurple.shade50,
              shape: CircleBorder(),
              padding: EdgeInsets.all(8),
              child: Image(
                image: NetworkImage(crts[i]['icon_uri']),
              ),
            ));
          }
        }
      }
    });
  }

  void _getFish() async {
    //var fish = <dynamic>[];
    const dataUrl = "http://acnhapi.com/v1/fish/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    fish = temp.entries.map((e) => e.value).toList();

    print("ACTUAL fish: ${fish[0]["availability"]["month-array-northern"]}");
    print('Current hour: ${DateTime.now().hour}');

    setState(() {
      for (var i = 0; i < fish.length; i++) {
        Fish newFish = Fish();
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

        if ((fish[i]["availability"]["month-array-northern"] as List)
            .contains(DateTime.now().month)) {
          if ((fish[i]["availability"]["time-array"] as List)
              .contains(DateTime.now().hour)) {
            _buttons.add(RawMaterialButton(
              onPressed: () {
                _showFish(newFish);
              },
              elevation: 2.0,
              fillColor: Colors.blue.shade50,
              shape: CircleBorder(),
              padding: EdgeInsets.all(8),
              child: Image(
                image: NetworkImage(fish[i]['icon_uri']),
              ),
            ));
          }
        }
      }
    });
  }

  void _getBugs() async {
    const dataUrl = "http://acnhapi.com/v1/bugs/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    bugs = temp.entries.map((e) => e.value).toList();

    print("ACTUAL bug: ${bugs[0]["availability"]["month-array-northern"]}");
    print('Current hour: ${DateTime.now().hour}');

    setState(() {
      for (var i = 0; i < bugs.length; i++) {
        Bug newCritter = Bug();
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

        if ((bugs[i]["availability"]["month-array-northern"] as List)
            .contains(DateTime.now().month)) {
          if ((bugs[i]["availability"]["time-array"] as List)
              .contains(DateTime.now().hour)) {
            _buttons.add(RawMaterialButton(
              onPressed: () {
                _showBug(newCritter);
              },
              elevation: 2.0,
              fillColor: Colors.amber.shade100,
              shape: CircleBorder(),
              padding: EdgeInsets.all(8),
              child: Image(
                image: NetworkImage(bugs[i]['icon_uri']),
              ),
            ));
          }
        }
      }
    });
  }
}

/*
shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(180.0),
                            side: BorderSide(color: Colors.red))),
                  )
 */
