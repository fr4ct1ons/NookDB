import 'package:flutter/material.dart';

class BugView extends StatefulWidget {
  BugView({Key? key, required this.bugs, required this.index})
      : super(key: key);
  var bugs;
  int index;

  @override
  _BugViewState createState() => _BugViewState();
}

class _BugViewState extends State<BugView> {
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
  var bugs = <dynamic>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    index = widget.index;
    bugs = widget.bugs;

    textGrid = [];
    _generateTextGrid();
    monthsGrid = [];

    for (var i = 0; i < months.length; i++) {
      Color highlight = Colors.orange.shade100;
      if ((bugs[index]["availability"]["month-array-northern"] as List)
          .contains(i + 1)) {
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
  }

  @override
  Widget build(BuildContext context) {
    String bugName = bugs[index]['name']['name-USen'];
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
              Image(image: NetworkImage(bugs[index]['image_uri'])),
              Text(
                bugs[index]['catch-phrase'],
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
      ),
    );
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
      textGrid.addAll(
          _drawTextPair("Location", bugs[index]['availability']['location']));
      textGrid.addAll(_drawTextPair(
          "Availability",
          bugs[index]['availability']['isAllDay']
              ? 'All day'
              : bugs[index]['availability']['time']));
      textGrid.addAll(
          _drawTextPair("Rarity", bugs[index]['availability']['rarity']));
      //textGrid.addAll(_drawTextPair("Availability", "All day"));
      //textGrid.addAll(_drawTextPair("Shadow size", bugs[index]['shadow']));
      textGrid.addAll(_drawTextPair("Price", bugs[index]['price'].toString()));
      textGrid.addAll(_drawTextPair(
          "Flick's price", bugs[index]['price-flick'].toString()));
    });
  }
}
