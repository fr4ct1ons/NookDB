import 'package:flutter/material.dart';
import 'package:nook_db/availableCritters.dart';
import 'package:nook_db/ui/view/bugView.dart';
import 'package:nook_db/buttonGrid.dart';
import 'package:nook_db/ui/view/fishView.dart';
import 'package:nook_db/ui/view/seaCreatureView.dart';
import 'package:nook_db/structs.dart';
import '../../todoList.dart';

class CritterSearch extends StatefulWidget {
  const CritterSearch({Key? key}) : super(key: key);

  @override
  State<CritterSearch> createState() => _CritterSearchState();
}

class _CritterSearchState extends State<CritterSearch> {
  String searchQuery = '';
  bool showFish = true;
  bool showBugs = true;
  bool showCreatures = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text("Search critters"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Critter name"),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            Row(
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
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: _listBuilder,
                itemCount: critters.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listBuilder(BuildContext ctx, int i) {
    Color bg = Colors.white;

    if (critters[i] is Bug) {
      if (!showBugs) {
        return SizedBox.shrink();
      } else {
        bg = Colors.amber.shade100;
      }
    }

    if (critters[i] is Fish) {
      if (!showFish) {
        return SizedBox.shrink();
      } else {
        bg = Colors.blue.shade50;
      }
    }
    if (critters[i] is Creature) {
      if (!showCreatures)
        return SizedBox.shrink();
      else {
        bg = Colors.deepPurple.shade50;
      }
    }

    if (searchQuery.isNotEmpty) {
      if (searchQuery.length <= critters[i].usName.length) {
        if (searchQuery.toLowerCase() !=
            critters[i].usName.toLowerCase().substring(0, searchQuery.length)) {
          return SizedBox.shrink();
        }
      } else {
        return SizedBox.shrink();
      }
    }
    return GestureDetector(
      onTap: () {
        _showCritter(critters[i]);
      },
      child: Card(
        color: bg,
        child: Row(
          children: [
            Image(
              height: 110,
              image: NetworkImage(critters[i].iconUrl),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  critters[i].uppercaseName(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Price: ${critters[i].price}",
                  style: TextStyle(fontSize: 15),
                ),
                Row(
                  children: [
                    Text(
                      critters[i].isActive()
                          ? "Currently active"
                          : "Currently inactive",
                      style: TextStyle(fontSize: 17),
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

  void _showCritter(Critter critter) async {
    if (critter is Bug) {
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return BugView(
            bug: critter as Bug,
          );
        },
      ));
    } else if (critter is Fish) {
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return FishView(
            fish: critter as Fish,
          );
        },
      ));
    } else if (critter is Creature) {
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return SeaCreatureView(
            creature: critter as Creature,
          );
        },
      ));
    }
  }
}
