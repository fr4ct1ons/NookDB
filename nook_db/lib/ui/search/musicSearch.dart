import 'package:flutter/material.dart';
import 'package:nook_db/ui/view/artView.dart';
import 'package:nook_db/structs.dart';
import 'package:nook_db/ui/view/musicView.dart';

class MusicSearch extends StatefulWidget {
  const MusicSearch({Key? key}) : super(key: key);

  @override
  State<MusicSearch> createState() => _MusicSearchState();
}

class _MusicSearchState extends State<MusicSearch> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text("Search music"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Music name"),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: _listBuilder,
                itemCount: musics.length,
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
      if (searchQuery.length <= musics[i].usName.length) {
        if (searchQuery.toLowerCase() !=
            musics[i]
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
        _showMusic(musics[i]);
      },
      child: Card(
        color: bg,
        child: Row(
          children: [
            Image(
              height: 110,
              image: NetworkImage(musics[i].imageUrl),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  musics[i].uppercaseName(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Purchase for: ${musics[i].buyPrice == -1 ? 'Non-purchasable' : musics[i].buyPrice}",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      "Sell for: ${musics[i].sellPrice == -1 ? 'Non-sellable' : musics[i].sellPrice}",
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

  void _showMusic(Music music) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return MusicView(
          music: music,
        );
      },
    ));
  }
}
