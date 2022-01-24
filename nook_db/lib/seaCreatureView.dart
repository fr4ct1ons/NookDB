import 'package:flutter/material.dart';

class SeaCreatureView extends StatefulWidget {
  SeaCreatureView({Key? key, required this.crts, required this.index})
      : super(key: key);
  var crts;
  int index;

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

  int index = 0;
  var crts = <dynamic>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    index = widget.index;
    crts = widget.crts;

    textGrid = [];
    _generateTextGrid();
    monthsGrid = [];

    for (var i = 0; i < months.length; i++) {
      Color highlight = Colors.deepPurple.shade100;
      if ((crts[index]["availability"]["month-array-northern"] as List)
          .contains(i + 1)) {
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
  }

  @override
  Widget build(BuildContext context) {
    String creatureName = crts[index]['name']['name-USen'];
    creatureName = creatureName[0].toUpperCase() + creatureName.substring(1);

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
              Image(image: NetworkImage(crts[index]['image_uri'])),
              Text(
                crts[index]['catch-phrase'],
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
          "Availability",
          crts[index]['availability']['isAllDay']
              ? 'All day'
              : crts[index]['availability']['time']));
      textGrid.addAll(_drawTextPair("Speed", crts[index]['speed']));
      //textGrid.addAll(_drawTextPair("Availability", "All day"));
      textGrid.addAll(_drawTextPair("Shadow size", crts[index]['shadow']));
      textGrid.addAll(_drawTextPair("Price", crts[index]['price'].toString()));
      //textGrid.addAll(_drawTextPair("Flick's price", crts[index]['price-flick'].toString()));
    });
  }
}
