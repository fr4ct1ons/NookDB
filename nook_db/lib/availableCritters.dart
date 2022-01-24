import 'package:flutter/material.dart';
import 'package:nook_db/fishView.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AvailableCritters extends StatefulWidget {
  const AvailableCritters({Key? key}) : super(key: key);

  @override
  _AvailableCrittersState createState() => _AvailableCrittersState();
}

class _AvailableCrittersState extends State<AvailableCritters> {
  List<Widget> _buttons = [];
  var fish = <dynamic>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getCritters();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemCount: _buttons.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return _buttons[index];
        },
      ),
    );
  }

  void _showCritter(int index) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return FishView(
          fish: fish, //TODO: Create a critter/fish class
          index: index,
        );
      },
    ));
  }

  void _getCritters() async {
    //var fish = <dynamic>[];
    const dataUrl = "http://acnhapi.com/v1/fish/";
    final response = await http.get(Uri.parse(dataUrl));

    var temp = (json.decode(response.body)) as Map;

    //print('Fish: ${temp['bitterling']}');

    fish = temp.entries.map((e) => e.value).toList();

    print("ACTUAL fish: ${fish[0]["availability"]["month-array-northern"]}");
    print('Current hour: ${DateTime.now().hour}');

    setState(() {
      for (var i = 0; i < fish.length; i++) {
        if ((fish[i]["availability"]["month-array-northern"] as List)
            .contains(DateTime.now().month)) {
          if ((fish[i]["availability"]["time-array"] as List)
              .contains(DateTime.now().hour)) {
            _buttons.add(RawMaterialButton(
              onPressed: () {
                _showCritter(i);
              },
              elevation: 2.0,
              fillColor: Colors.white,
              shape: CircleBorder(),
              padding: EdgeInsets.all(8),
              child: Image(
                image: NetworkImage(fish[i]['icon_uri']),
              ),
            ));
          }
        }
      }
    });
  }
}

/*
shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(180.0),
                            side: BorderSide(color: Colors.red))),
                  )
 */
