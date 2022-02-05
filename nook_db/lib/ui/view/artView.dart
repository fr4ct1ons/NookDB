import 'package:flutter/material.dart';
import 'package:nook_db/structs.dart';

class ArtView extends StatefulWidget {
  ArtView({Key? key, required this.art}) : super(key: key);
  Art art;

  @override
  _ArtViewState createState() => _ArtViewState();
}

class _ArtViewState extends State<ArtView> {
  List<Widget> textGrid = [];
  List<Widget> monthsGrid = [];

  Art art = Art();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    art = widget.art;

    textGrid = [];
    _generateTextGrid();
    monthsGrid = [];
  }

  @override
  Widget build(BuildContext context) {
    String bugName = art.uppercaseName();

    return Theme(
      data: ThemeData(primarySwatch: Colors.cyan),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Art piece"),
        ),
        backgroundColor: Colors.cyan.shade50,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  bugName,
                  style: TextStyle(fontSize: 24),
                ),
                Image(
                  image: NetworkImage(art.imageUrl),
                  height: 256,
                  fit: BoxFit.fitHeight,
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
                  Padding(padding: EdgeInsets.all(8), child: Text(art.museumDesc, style: TextStyle(fontSize: 18.0), textAlign: TextAlign.justify,),)
              ],
            ),
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
        color: Colors.cyan.shade100,
        child: Text(
          lhs,
          style: TextStyle(fontSize: textSize),
          textAlign: TextAlign.right,
        ),
      ),
      Container(
          padding: EdgeInsets.all(4),
          color: Colors.cyan.shade200,
          child: Text(
            rhs,
            style: TextStyle(fontSize: textSize),
            textAlign: TextAlign.left,
          ))
    ];
  }

  void _generateTextGrid() {
    setState(() {
      textGrid.addAll(_drawTextPair("Purchase price",
          art.buyPrice == -1 ? "Unpurchasable" : art.buyPrice.toString()));
      textGrid.addAll(_drawTextPair("Sell price",
          art.sellPrice == -1 ? "Non-sellable" : art.sellPrice.toString()));
      textGrid.addAll(_drawTextPair("Has fake", art.hasFake ? "Yes" : 'No'));
      //textGrid.addAll(_drawTextPair("CJ's price", fish.priceCj.toString()));
    });
  }
}
