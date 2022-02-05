import 'package:flutter/material.dart';
import 'package:nook_db/database.dart';
import 'package:nook_db/structs.dart';

class FishView extends StatefulWidget {
  FishView({Key? key, required this.fish}) : super(key: key);
  Fish fish;

  @override
  _FishViewState createState() => _FishViewState();
}

class _FishViewState extends State<FishView> {
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

  Fish fish = Fish();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fish = widget.fish;

    textGrid = [];
    _generateTextGrid();
    monthsGrid = [];

    for (var i = 0; i < months.length; i++) {
      Color highlight = Colors.blue.shade100;
      if ((fish.monthArrayNorth.contains(i + 1) && isNorthernHemisphere) ||
          (fish.monthArraySouth.contains(i + 1) && !isNorthernHemisphere)) {
        highlight = Colors.blueAccent.shade100;
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

    if (trackedFish.containsKey(fish.id)) {
      if (trackedFish[fish.id]!.isTracked()) {
        isTracked = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String fishName = fish.uppercaseName();

    return Theme(
      data: ThemeData(primarySwatch: Colors.blue),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Fish"),
        ),
        backgroundColor: Colors.blue.shade50,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  fishName,
                  style: TextStyle(fontSize: 24),
                ),
                Image(image: NetworkImage(fish.imageUrl)),
                Text(
                  fish.catchPhrase,
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
                ),
                  Padding(padding: EdgeInsets.all(8), child: Text(fish.museumPhrase, style: TextStyle(fontSize: 18.0), textAlign: TextAlign.justify,),)
                /*CheckboxListTile(
                    value: true,
                    onChanged: (val) {},
                    title: Text("Track thi critter?")),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startTracking(bool? val) {
    if (trackedFish.containsKey(fish.id)) {
      if (trackedFish[fish.id]!.isTracked()) {
        if (val! == false) {
          stopTrackingCritter(fish);
          setState(() {
            isTracked = false;
          });
        }
      }
    } else {
      trackCritter(fish);
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
        color: Colors.blue.shade100,
        child: Text(
          lhs,
          style: TextStyle(fontSize: textSize),
          textAlign: TextAlign.right,
        ),
      ),
      Container(
          padding: EdgeInsets.all(4),
          color: Colors.blue.shade200,
          child: Text(
            rhs,
            style: TextStyle(fontSize: textSize),
            textAlign: TextAlign.left,
          ))
    ];
  }

  void _generateTextGrid() {
    setState(() {
      textGrid.addAll(_drawTextPair("Location", fish.location));
      textGrid.addAll(
          _drawTextPair("Availability", fish.isAllDay ? 'All day' : fish.time));
      textGrid.addAll(_drawTextPair("Rarity", fish.rarity));
      //textGrid.addAll(_drawTextPair("Availability", "All day"));
      textGrid.addAll(_drawTextPair("Shadow size", fish.shadow));
      textGrid.addAll(_drawTextPair("Price", fish.price.toString()));
      textGrid.addAll(_drawTextPair("CJ's price", fish.priceCj.toString()));
    });
  }
}
