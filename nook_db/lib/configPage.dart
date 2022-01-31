import 'package:flutter/material.dart';
import 'structs.dart' as structs;

class ConfigPage extends StatefulWidget {
  const ConfigPage({ Key? key }) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Configurations"),),
    body: ListView(children: [
      SwitchListTile(value: structs.isNorthernHemisphere, onChanged: (value) {
        setState(() {
          structs.isNorthernHemisphere = value;
        });
      }, title: Text("Northern Hemisphere"),)
    ],),);
  }
}