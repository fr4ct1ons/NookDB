import 'package:flutter/material.dart';
import 'package:nook_db/availableCritters.dart';
import 'package:nook_db/ui/view/bugView.dart';
import 'package:nook_db/buttonGrid.dart';
import 'package:nook_db/ui/view/fishView.dart';
import 'package:nook_db/ui/view/itemView.dart';
import 'package:nook_db/ui/view/seaCreatureView.dart';
import 'package:nook_db/structs.dart';
import '../../todoList.dart';

class ItemSearch extends StatefulWidget {
  const ItemSearch({Key? key}) : super(key: key);

  @override
  State<ItemSearch> createState() => _ItemSearchState();
}

class _ItemSearchState extends State<ItemSearch> {
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
              decoration: InputDecoration(labelText: "Item name"),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Checkbox(
                  value: showFish,
                  onChanged: (value) {
                    setState(() {
                      showFish = value!;
                    });
                  },
                ),
                Text("Fish"),
                Checkbox(
                  value: showBugs,
                  onChanged: (value) {
                    setState(() {
                      showBugs = value!;
                    });
                  },
                ),
                Text("Bugs"),
                Checkbox(
                  value: showCreatures,
                  onChanged: (value) {
                    setState(() {
                      showCreatures = value!;
                    });
                  },
                ),
                Text("Creatures"),
              ],
            ),*/
            Expanded(
              child: ListView.builder(
                itemBuilder: _listBuilder,
                itemCount: items.length,
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
      if (searchQuery.length <= items[i].usName.length) {
        if (searchQuery.toLowerCase() !=
            items[i].usName.toLowerCase().substring(0, searchQuery.length)) {
          return SizedBox.shrink();
        }
      } else {
        return SizedBox.shrink();
      }
    }
    return GestureDetector(
      onTap: () {
        _showItem(items[i]);
      },
      child: Card(
        color: bg,
        child: Row(
          children: [
            Image(
              height: 110,
              image: NetworkImage(items[i].imageUrl),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  items[i].uppercaseName(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Purchase for: ${items[i].buyPrice == -1 ? 'Non-purchasable' : items[i].buyPrice}",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      "Sell for: ${items[i].sellPrice == -1 ? 'Non-sellable' : items[i].sellPrice}",
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

  void _showItem(Item item) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ItemView(
          item: item,
        );
      },
    ));
  }
}
