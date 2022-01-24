import 'package:flutter/material.dart';

class FishView extends StatefulWidget {
  const FishView({Key? key}) : super(key: key);

  @override
  _FishViewState createState() => _FishViewState();
}

class _FishViewState extends State<FishView> {
  List<Widget> textGrid = [];
  List<Widget> monthsGrid = [
    Text("Jan"),
    Text("Feb"),
    Text("Mar"),
    Text("Apr"),
    Text("May"),
    Text("Jun"),
    Text("Jul"),
    Text("Aug"),
    Text("Sep"),
    Text("Oct"),
    Text("Nov"),
    Text("Dec"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textGrid = [];
    _generateTextGrid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fish"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              "Bitterling",
              style: TextStyle(fontSize: 24),
            ),
            Image(image: NetworkImage('https://acnhapi.com/v1/images/fish/1')),
            Text(
              "I caught a bitterling! It's mad at me, but only a little.",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            SizedBox(
              height: 15,
            ),
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //crossAxisSpacing: 8,
                  //mainAxisSpacing: 3,
                  childAspectRatio: 1 / .15),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: textGrid,
            ),
            SizedBox(
              height: 15,
            ),
            Text("Available during"),
            GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
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
        color: Colors.yellow.shade50,
        child: Text(
          lhs,
          style: TextStyle(fontSize: textSize),
          textAlign: TextAlign.right,
        ),
      ),
      Container(
          padding: EdgeInsets.all(2),
          color: Colors.yellow.shade100,
          child: Text(
            rhs,
            style: TextStyle(fontSize: textSize),
            textAlign: TextAlign.left,
          ))
    ];
  }

  void _generateTextGrid() {
    setState(() {
      textGrid.addAll(_drawTextPair("Location", "River"));
      textGrid.addAll(_drawTextPair("Availability", "All day"));
      textGrid.addAll(_drawTextPair("Rarity", "Common"));
      textGrid.addAll(_drawTextPair("Availability", "All day"));
      textGrid.addAll(_drawTextPair("Shadow size", "Smallest"));
      textGrid.addAll(_drawTextPair("Price", "900 bells"));
      textGrid.addAll(_drawTextPair("CJ's price", "1350"));
    });
  }
}
