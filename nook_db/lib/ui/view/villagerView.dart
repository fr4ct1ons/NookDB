import 'package:flutter/material.dart';
import 'package:nook_db/structs.dart';

class VillagerView extends StatefulWidget {
  VillagerView({Key? key, required this.villager}) : super(key: key);
  Villager villager;

  @override
  _VillagerViewState createState() => _VillagerViewState();
}

class _VillagerViewState extends State<VillagerView> {
  List<Widget> textGrid = [];

  Villager villager = Villager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    villager = widget.villager;

    textGrid = [];
    _generateTextGrid();
  }

  @override
  Widget build(BuildContext context) {
    String villagerName = villager.uppercaseName();

    return Scaffold(
      appBar: AppBar(
        title: Text("Fish"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                villagerName,
                style: TextStyle(fontSize: 24),
              ),
              Image(image: NetworkImage(villager.imageUrl)),
              SizedBox(
                height: 10,
              ),
              Text(
                villager.catchphrase,
                style: TextStyle(color: Colors.grey.shade600),
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
        color: Colors.green.shade100,
        child: Text(
          lhs,
          style: TextStyle(fontSize: textSize),
          textAlign: TextAlign.right,
        ),
      ),
      Container(
          padding: EdgeInsets.all(4),
          color: Colors.green.shade200,
          child: Text(
            rhs,
            style: TextStyle(fontSize: textSize),
            textAlign: TextAlign.left,
          ))
    ];
  }

  void _generateTextGrid() {
    setState(() {
      textGrid.addAll(_drawTextPair("Personality", villager.personality));
      textGrid.addAll(_drawTextPair("Birhtday", villager.birthdayName));
      textGrid.addAll(_drawTextPair("Species", villager.species));
      textGrid.addAll(_drawTextPair("Gender", villager.gender));
    });
  }
}
