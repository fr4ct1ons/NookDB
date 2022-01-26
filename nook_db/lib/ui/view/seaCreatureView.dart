import 'package:flutter/material.dart';
import 'package:nook_db/structs.dart';
import 'package:nook_db/database.dart' as db;

class SeaCreatureView extends StatefulWidget {
  SeaCreatureView({Key? key, required this.creature}) : super(key: key);
  Creature creature;

  @override
  _SeaCreatureViewState createState() => _SeaCreatureViewState();
}

class _SeaCreatureViewState extends State<SeaCreatureView> {
  List<Widget> textGrid = [];
  List<Widget> monthsGrid = [];

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  Creature creature = Creature();
  bool isTracked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    creature = widget.creature;

    textGrid = [];
    _generateTextGrid();
    monthsGrid = [];

    for (var i = 0; i < months.length; i++) {
      Color highlight = Colors.deepPurple.shade100;
      if (creature.monthArrayNorth.contains(i + 1)) {
        highlight = Colors.deepPurpleAccent.shade100;
      }

      monthsGrid.add(Card(
        child: Center(
          child: Text(
            months[i],
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        color: highlight,
      ));
    }

    if (db.trackedCreature.containsKey(creature.id)) {
      if (db.trackedCreature[creature.id]!.isTracked()) {
        isTracked = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String creatureName = creature.usName;
    creatureName = creature.uppercaseName();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sea creature"),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.deepPurple.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                creatureName,
                style: TextStyle(fontSize: 24),
              ),
              Image(image: NetworkImage(creature.imageUrl)),
              Text(
                creature.catchPhrase,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 15,
              ),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //crossAxisSpacing: 8,
                    //mainAxisSpacing: 3,
                    childAspectRatio: 1 / .18),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: textGrid,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Available during",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 12,
              ),
              GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, childAspectRatio: 1 / 0.85),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: monthsGrid,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Track this critter?"),
                  Checkbox(value: isTracked, onChanged: _startTracking)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _startTracking(bool? val) {
    if (db.trackedCreature.containsKey(creature.id)) {
      if (db.trackedCreature[creature.id]!.isTracked()) {
        if (val! == false) {
          db.stopTrackingCritter(creature);
          setState(() {
            isTracked = false;
          });
        }
      }
    } else {
      db.trackCritter(creature);
      setState(() {
        isTracked = true;
      });
    }
  }

  List<Widget> _drawTextPair(String lhs, String rhs) {
    const double textSize = 18;
    return [
      Container(
        padding: EdgeInsets.all(4),
        color: Colors.deepPurple.shade100,
        child: Text(
          lhs,
          style: TextStyle(fontSize: textSize),
          textAlign: TextAlign.right,
        ),
      ),
      Container(
          padding: EdgeInsets.all(4),
          color: Colors.deepPurple.shade200,
          child: Text(
            rhs,
            style: TextStyle(fontSize: textSize),
            textAlign: TextAlign.left,
          ))
    ];
  }

  void _generateTextGrid() {
    setState(() {
      //textGrid.addAll(_drawTextPair("Location", crts[index]['availability']['location']));
      textGrid.addAll(_drawTextPair(
          "Availability", creature.isAllDay ? 'All day' : creature.time));
      textGrid.addAll(_drawTextPair("Speed", creature.speed));
      //textGrid.addAll(_drawTextPair("Availability", "All day"));
      textGrid.addAll(_drawTextPair("Shadow size", creature.shadow));
      textGrid.addAll(_drawTextPair("Price", creature.price.toString()));
      //textGrid.addAll(_drawTextPair("Flick's price", crts[index]['price-flick'].toString()));
    });
  }
}
