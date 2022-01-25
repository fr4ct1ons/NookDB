import 'package:flutter/material.dart';
import 'package:nook_db/ui/view/artView.dart';
import 'package:nook_db/availableCritters.dart';
import 'package:nook_db/ui/view/bugView.dart';
import 'package:nook_db/buttonGrid.dart';
import 'package:nook_db/ui/view/fishView.dart';
import 'package:nook_db/ui/view/itemView.dart';
import 'package:nook_db/ui/view/seaCreatureView.dart';
import 'package:nook_db/structs.dart';
import '../../todoList.dart';

class ArtSearch extends StatefulWidget {
  const ArtSearch({Key? key}) : super(key: key);

  @override
  State<ArtSearch> createState() => _ArtSearchState();
}

class _ArtSearchState extends State<ArtSearch> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text("Search items"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Art piece name"),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: _listBuilder,
                itemCount: artPieces.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listBuilder(BuildContext ctx, int i) {
    Color bg = Colors.white;

    if (searchQuery.isNotEmpty) {
      if (searchQuery.length <= artPieces[i].usName.length) {
        if (searchQuery.toLowerCase() !=
            artPieces[i]
                .usName
                .toLowerCase()
                .substring(0, searchQuery.length)) {
          return SizedBox.shrink();
        }
      } else {
        return SizedBox.shrink();
      }
    }
    return GestureDetector(
      onTap: () {
        _showArt(artPieces[i]);
      },
      child: Card(
        color: bg,
        child: Row(
          children: [
            Image(
              height: 110,
              image: NetworkImage(artPieces[i].imageUrl),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artPieces[i].uppercaseName(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Purchase for: ${artPieces[i].buyPrice == -1 ? 'Non-purchasable' : artPieces[i].buyPrice}",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      "Sell for: ${artPieces[i].sellPrice == -1 ? 'Non-sellable' : artPieces[i].sellPrice}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showArt(Art art) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ArtView(
          art: art,
        );
      },
    ));
  }
}
