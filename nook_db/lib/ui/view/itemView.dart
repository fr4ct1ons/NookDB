import 'package:flutter/material.dart';
import 'package:nook_db/structs.dart';

class ItemView extends StatefulWidget {
  ItemView({Key? key, required this.item}) : super(key: key);
  Item item;

  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  List<Widget> textGrid = [];

  Item item = Item();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    item = widget.item;

    textGrid = [];
    _generateTextGrid();
    //monthsGrid = [];

    /*for (var i = 0; i < months.length; i++) {
      Color highlight = Colors.blue.shade100;
      if (fish.monthArrayNorth.contains(i + 1)) {
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
    }*/
  }

  @override
  Widget build(BuildContext context) {
    String itemName = item.uppercaseName();

    return Scaffold(
      appBar: AppBar(
        title: Text("item"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                itemName,
                style: TextStyle(fontSize: 24),
              ),
              Image(
                image: NetworkImage(item.imageUrl),
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
              Text(
                item.sourceDetail,
                style: TextStyle(fontSize: 16),
              ),

              /*GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, childAspectRatio: 1 / 0.85),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: monthsGrid,
              ),*/
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
      textGrid.addAll(_drawTextPair("Size", item.size));
      textGrid.addAll(_drawTextPair("Customizable",
          item.bodyCustomizable || item.patternCustomizable ? 'Yes' : 'No'));
      textGrid.addAll(_drawTextPair("Purchase price",
          item.buyPrice == -1 ? "Unpurchasable" : item.buyPrice.toString()));
      textGrid.addAll(_drawTextPair("Sell price",
          item.sellPrice == -1 ? "Non-sellable" : item.sellPrice.toString()));
      textGrid.addAll(_drawTextPair("Found at", item.source));
      textGrid.addAll(_drawTextPair("Is D.I.Y", item.isDiy ? "Yes" : "No"));
      //textGrid.addAll(_drawTextPair("CJ's price", fish.priceCj.toString()));
    });
  }
}
