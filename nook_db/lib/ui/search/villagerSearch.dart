import 'package:flutter/material.dart';
import 'package:nook_db/ui/search/villagerSearch.dart';
import 'package:nook_db/ui/view/artView.dart';
import 'package:nook_db/structs.dart';
import 'package:nook_db/ui/view/fossilView.dart';
import 'package:nook_db/ui/view/villagerView.dart';

class VillagerSearch extends StatefulWidget {
  const VillagerSearch({Key? key}) : super(key: key);

  @override
  State<VillagerSearch> createState() => _VillagerSearchState();
}

class _VillagerSearchState extends State<VillagerSearch> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text("Search villager"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Villager name"),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: _listBuilder,
                itemCount: villagers.length,
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
      if (searchQuery.length <= villagers[i].usName.length) {
        if (searchQuery.toLowerCase() !=
            villagers[i]
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
        _showVillager(villagers[i]);
      },
      child: Card(
        color: bg,
        child: Row(
          children: [
            Image(
              height: 110,
              image: NetworkImage(villagers[i].iconUrl),
            ),
            SizedBox(
              width: 8,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                villagers[i].uppercaseName(),
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Birthday: ${villagers[i].birthdayName}",
                style: TextStyle(fontSize: 16),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void _showVillager(Villager villager) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return VillagerView(
          villager: villager,
        );
      },
    ));
  }
}
