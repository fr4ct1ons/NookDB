import 'package:flutter/material.dart';
import 'package:nook_db/structs.dart';

class FossilView extends StatefulWidget {
  FossilView({Key? key, required this.fossil}) : super(key: key);
  Fossil fossil;

  @override
  _FossilViewState createState() => _FossilViewState();
}

class _FossilViewState extends State<FossilView> {
  List<Widget> textGrid = [];
  List<Widget> monthsGrid = [];

  Fossil fossil = Fossil();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fossil = widget.fossil;

    textGrid = [];
    _generateTextGrid();
    monthsGrid = [];
  }

  @override
  Widget build(BuildContext context) {
    String bugName = fossil.uppercaseName();

    return Scaffold(
      appBar: AppBar(
        title: Text("Art piece"),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                bugName,
                style: TextStyle(fontSize: 24),
              ),
              Image(image: NetworkImage(fossil.imageUrl)),
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
        color: Colors.brown.shade100,
        child: Text(
          lhs,
          style: TextStyle(fontSize: textSize),
          textAlign: TextAlign.right,
        ),
      ),
      Container(
          padding: EdgeInsets.all(4),
          color: Colors.brown.shade200,
          child: Text(
            rhs,
            style: TextStyle(fontSize: textSize),
            textAlign: TextAlign.left,
          ))
    ];
  }

  void _generateTextGrid() {
    setState(() {
      textGrid.addAll(_drawTextPair("Sell price",
          fossil.price == -1 ? "Non-sellable" : fossil.price.toString()));
    });
  }
}
