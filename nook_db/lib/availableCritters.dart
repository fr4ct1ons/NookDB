import 'package:flutter/material.dart';
import 'package:nook_db/ui/view/bugView.dart';
import 'package:nook_db/ui/view/fishView.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nook_db/ui/view/seaCreatureView.dart';
import 'structs.dart';
import 'database.dart' as db;

class AvailableCritters extends StatefulWidget {
  const AvailableCritters({Key? key}) : super(key: key);
  

  @override
  AvailableCrittersState createState() => AvailableCrittersState();
}

class AvailableCrittersState extends State<AvailableCritters> {
  List<Widget> _buttons = [];
  List<Fish> fish = [];
  List<Bug> bugs = [];
  List<Creature> crts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCritters();
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
    )).then((value) {
      setState(() {
        getCritters();
      });
    });
  }

  void _showCreature(Creature creature) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SeaCreatureView(
          creature: creature,
        );
      },
    )).then((value) {
      setState(() {
        getCritters();
      });
    });
  }

  void _showBug(Bug bug) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return BugView(
          bug: bug,
        );
      },
    )).then((value) {
      setState(() {
        getCritters();
      });
    });
    ;
  }

  void getCritters() {
    _buttons = [];
    _getFish();
    _getBugs();
    _getSeaCreatures();
  }

  void _getFish() {
    fish = critters.whereType<Fish>().toList();
    for (var i = 0; i < fish.length; i++) {
      if (fish[i].isActive()) {
        bool isTracked = false;

        if (db.trackedFish.containsKey(fish[i].id)) {
          if (db.trackedFish[fish[i].id]!.isTracked()) {
            isTracked = true;
          }
        }
        var widget = RawMaterialButton(
          onPressed: () {
            _showFish(fish[i]);
          },
          elevation: 2.0,
          fillColor: isTracked ? Colors.blue.shade300 : Colors.blue.shade50,
          shape: CircleBorder(),
          padding: EdgeInsets.all(8),
          child: Image(
            image: NetworkImage(fish[i].iconUrl),
          ),
        );

        isTracked ? _buttons.insert(0, widget) : _buttons.add(widget);
      }
    }
  }

  void _getBugs() {
    bugs = critters.whereType<Bug>().toList();

    for (var i = 0; i < bugs.length; i++) {
      if (bugs[i].isActive()) {
        bool isTracked = false;

        if (db.trackedBug.containsKey(bugs[i].id)) {
          if (db.trackedBug[bugs[i].id]!.isTracked()) {
            isTracked = true;
          }
        }
        var widget = RawMaterialButton(
          onPressed: () {
            _showBug(bugs[i]);
          },
          elevation: 2.0,
          fillColor: isTracked ? Colors.amber.shade300 : Colors.amber.shade100,
          shape: CircleBorder(),
          padding: EdgeInsets.all(8),
          child: Image(
            image: NetworkImage(bugs[i].iconUrl),
          ),
        );

        isTracked ? _buttons.insert(0, widget) : _buttons.add(widget);
      }
    }
  }

  void _getSeaCreatures() {
    crts = critters.whereType<Creature>().toList();

    for (var i = 0; i < crts.length; i++) {
      if (crts[i].isActive()) {
        bool isTracked = false;

        if (db.trackedCreature.containsKey(crts[i].id)) {
          if (db.trackedCreature[crts[i].id]!.isTracked()) {
            isTracked = true;
          }
        }
        var widget = RawMaterialButton(
          onPressed: () {
            _showCreature(crts[i]);
          },
          elevation: 2.0,
          fillColor: isTracked
              ? Colors.deepPurple.shade300
              : Colors.deepPurple.shade50,
          shape: CircleBorder(),
          padding: EdgeInsets.all(8),
          child: Image(
            image: NetworkImage(crts[i].iconUrl),
          ),
        );

        isTracked ? _buttons.insert(0, widget) : _buttons.add(widget);
      }
    }
  }

  //EXPENSIVE
  void refreshCritters()
  {
    setState(() {
      getCritters();
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
