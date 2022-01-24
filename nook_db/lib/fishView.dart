import 'package:flutter/material.dart';

class FishView extends StatefulWidget {
  FishView({Key? key, required this.fish, required this.index})
      : super(key: key);
  var fish;
  int index;

  @override
  _FishViewState createState() => _FishViewState();
}

class _FishViewState extends State<FishView> {
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

  int index = 0;
  var fish = <dynamic>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    index = widget.index;
    fish = widget.fish;

    textGrid = [];
    _generateTextGrid();
    monthsGrid = [];

    for (var i = 0; i < months.length; i++) {
      Color highlight = Colors.blue.shade100;
      if ((fish[index]["availability"]["month-array-northern"] as List)
          .contains(i + 1)) {
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
  }

  @override
  Widget build(BuildContext context) {
    String fishName = fish[index]['name']['name-USen'];
    fishName = fishName[0].toUpperCase() + fishName.substring(1);

    return Scaffold(
      appBar: AppBar(
        title: Text("Fish"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              fishName,
              style: TextStyle(fontSize: 24),
            ),
            Image(image: NetworkImage(fish[index]['image_uri'])),
            Text(
              fish[index]['catch-phrase'],
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
            /*CheckboxListTile(
                value: true,
                onChanged: (val) {},
                title: Text("Track thi critter?")),*/
          ],
        ),
      ),
    );
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
      textGrid.addAll(
          _drawTextPair("Location", fish[index]['availability']['location']));
      textGrid.addAll(_drawTextPair(
          "Availability",
          fish[index]['availability']['isAllDay']
              ? 'All day'
              : fish[index]['availability']['time']));
      textGrid.addAll(
          _drawTextPair("Rarity", fish[index]['availability']['rarity']));
      //textGrid.addAll(_drawTextPair("Availability", "All day"));
      textGrid.addAll(_drawTextPair("Shadow size", fish[index]['shadow']));
      textGrid.addAll(_drawTextPair("Price", fish[index]['price'].toString()));
      textGrid.addAll(
          _drawTextPair("CJ's price", fish[index]['price-cj'].toString()));
    });
  }
}
