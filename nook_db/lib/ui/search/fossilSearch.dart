import 'package:flutter/material.dart';
import 'package:nook_db/ui/view/artView.dart';
import 'package:nook_db/structs.dart';
import 'package:nook_db/ui/view/fossilView.dart';

class FossilSearch extends StatefulWidget {
  const FossilSearch({Key? key}) : super(key: key);

  @override
  State<FossilSearch> createState() => _FossilSearchState();
}

class _FossilSearchState extends State<FossilSearch> {
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
                itemCount: fossils.length,
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
      if (searchQuery.length <= fossils[i].usName.length) {
        if (searchQuery.toLowerCase() !=
            fossils[i].usName.toLowerCase().substring(0, searchQuery.length)) {
          return SizedBox.shrink();
        }
      } else {
        return SizedBox.shrink();
      }
    }
    return GestureDetector(
      onTap: () {
        _showFossil(fossils[i]);
      },
      child: Card(
        color: bg,
        child: Row(
          children: [
            Image(
              height: 110,
              image: NetworkImage(fossils[i].imageUrl),
            ),
            SizedBox(
              width: 8,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                fossils[i].uppercaseName(),
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Price: ${fossils[i].price == -1 ? 'Non-purchasable' : fossils[i].price}",
                style: TextStyle(fontSize: 16),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void _showFossil(Fossil fossil) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return FossilView(
          fossil: fossil,
        );
      },
    ));
  }
}
