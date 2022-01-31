import 'package:flutter/material.dart';
import 'package:nook_db/structs.dart';
import 'package:nook_db/database.dart' as db;

class BugView extends StatefulWidget {
  BugView({Key? key, required this.bug}) : super(key: key);
  Bug bug;

  @override
  _BugViewState createState() => _BugViewState();
}

class _BugViewState extends State<BugView> {
  bool isTracked = false;
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

  Bug bug = Bug();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bug = widget.bug;

    textGrid = [];
    _generateTextGrid();
    monthsGrid = [];

    for (var i = 0; i < months.length; i++) {
      Color highlight = Colors.orange.shade100;
      
      if ((bug.monthArrayNorth.contains(i + 1) && isNorthernHemisphere) ||
          (bug.monthArraySouth.contains(i + 1) && !isNorthernHemisphere)) {
        highlight = Colors.orangeAccent.shade100;
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

    if (db.trackedBug.containsKey(bug.id)) {
      if (db.trackedBug[bug.id]!.isTracked()) {
        isTracked = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String bugName = bug.usName;
    bugName = bugName[0].toUpperCase() + bugName.substring(1);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bug"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.yellow.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                bugName,
                style: TextStyle(fontSize: 24),
              ),
              Image(image: NetworkImage(bug.imageUrl)),
              Text(
                bug.catchPhrase,
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
    if (db.trackedBug.containsKey(bug.id)) {
      if (db.trackedBug[bug.id]!.isTracked()) {
        if (val! == false) {
          db.stopTrackingCritter(bug);
          setState(() {
            isTracked = false;
          });
        }
      }
    } else {
      db.trackCritter(bug);
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
        color: Colors.yellow.shade100,
        child: Text(
          lhs,
          style: TextStyle(fontSize: textSize),
          textAlign: TextAlign.right,
        ),
      ),
      Container(
          padding: EdgeInsets.all(4),
          color: Colors.yellow.shade200,
          child: Text(
            rhs,
            style: TextStyle(fontSize: textSize),
            textAlign: TextAlign.left,
          ))
    ];
  }

  void _generateTextGrid() {
    setState(() {
      textGrid.addAll(_drawTextPair("Location", bug.location));
      textGrid.addAll(
          _drawTextPair("Availability", bug.isAllDay ? 'All day' : bug.time));
      textGrid.addAll(_drawTextPair("Rarity", bug.rarity));
      //textGrid.addAll(_drawTextPair("Availability", "All day"));
      //textGrid.addAll(_drawTextPair("Shadow size", bugs[index]['shadow']));
      textGrid.addAll(_drawTextPair("Price", bug.price.toString()));
      textGrid
          .addAll(_drawTextPair("Flick's price", bug.priceFlick.toString()));
    });
  }
}
