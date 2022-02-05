import 'package:flutter/material.dart';
import 'package:nook_db/ui/search/VillagerSearch.dart';
import 'package:nook_db/ui/search/artSearch.dart';
import 'package:nook_db/ui/search/critterSearch.dart';
import 'package:nook_db/ui/search/fossilSearch.dart';
import 'package:nook_db/ui/search/itemSearch.dart';

import 'ui/search/musicSearch.dart';

class ButtonGrid extends StatefulWidget {
  ButtonGrid({Key? key, this.onReturnFromCritterSearch}) : super(key: key);

  final VoidCallback? onReturnFromCritterSearch;

  @override
  _ButtonGridState createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //constraints: BoxConstraints(maxHeight: double.infinity),
        //padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        //height: 250,
        child: Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Container(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 6, crossAxisSpacing: 3),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            //TODO: Refactor this, maybe?
            OutlinedButton(
                onPressed: _showCritterSearch,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: const [
                      Image(
                          height: 64, image: AssetImage("assets/critters.png")),
                      Text('Critters'),
                    ],
                  ),
                )),
            OutlinedButton(
                onPressed: _showArtSearch,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: const [
                      Image(height: 64, image: AssetImage("assets/art.png")),
                      Text('Art'),
                    ],
                  ),
                )),
            OutlinedButton(
                onPressed: _showItemSearch,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: const [
                      Image(height: 64, image: AssetImage("assets/items.png")),
                      Text('Items'),
                    ],
                  ),
                )),
            OutlinedButton(
                onPressed: _showVillagerSearch,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: const [
                      Image(
                          height: 64, image: AssetImage("assets/villager.png")),
                      Text('Villagers'),
                    ],
                  ),
                )),
            OutlinedButton(
                onPressed: _showFossilSearch,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: const [
                      Image(height: 64, image: AssetImage("assets/fossil.png")),
                      Text('Fossils'),
                    ],
                  ),
                )),
            OutlinedButton(
                onPressed: _showMusicSearch,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: const [
                      Image(
                          height: 64, image: AssetImage("assets/music.png")),
                      Text('Music'),
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }

  void _showMusicSearch() async
  {
    await Navigator.push(context, MaterialPageRoute(builder:(context) {
      return MusicSearch();
    },));
  }

  void _showCritterSearch() async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return CritterSearch();
      },
    )).then((value) => widget.onReturnFromCritterSearch!());
  }

  void _showItemSearch() async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ItemSearch();
      },
    ));
  }

  void _showArtSearch() async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ArtSearch();
      },
    ));
  }

  void _showFossilSearch() async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return FossilSearch();
      },
    ));
  }

  void _showVillagerSearch() async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return VillagerSearch();
      },
    ));
  }
}



/*
GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: [
          OutlinedButton(onPressed: () {}, child: Text('Critters')),
          OutlinedButton(onPressed: () {}, child: Text('Art')),
          OutlinedButton(onPressed: () {}, child: Text('Items')),
          OutlinedButton(onPressed: () {}, child: Text('Villagers')),
          OutlinedButton(onPressed: () {}, child: Text('Fossils')),
          OutlinedButton(onPressed: () {}, child: Text('Clothing')),
        ],
      ),
*/
