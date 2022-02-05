import 'package:flutter/material.dart';
import 'package:nook_db/musicPlayer.dart';
import 'package:nook_db/structs.dart';

class MusicView extends StatefulWidget {
  MusicView({Key? key, required this.music}) : super(key: key);
  Music music;

  @override
  _MusicViewState createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {
  List<Widget> textGrid = [];
  List<Widget> monthsGrid = [];

  Music music = Music();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    music = widget.music;

    textGrid = [];
    _generateTextGrid();
    monthsGrid = [];
  }

  @override
  Widget build(BuildContext context) {
    String bugName = music.uppercaseName();

    return Theme(
      data: ThemeData(primarySwatch: Colors.yellow),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Song"),
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
                Image(
                  image: NetworkImage(music.imageUrl),
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
                MusicPlayer(url: music.musicUrl,)
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
      textGrid.addAll(_drawTextPair("Purchase price",
          music.buyPrice == -1 ? "Unpurchasable" : music.buyPrice.toString()));
      textGrid.addAll(_drawTextPair("Sell price",
          music.sellPrice == -1 ? "Non-sellable" : music.sellPrice.toString()));
      textGrid.addAll(_drawTextPair("Orderable", music.isOrderable ? "Yes" : "No"));

      //textGrid.addAll(_drawTextPair("CJ's price", fish.priceCj.toString()));
    });
  }
}
