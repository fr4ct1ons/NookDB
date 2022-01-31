import 'package:flutter/material.dart';
import 'structs.dart' as structs;
import 'database.dart' as db;

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
      SwitchListTile(value: db.isNorthernHemisphere, onChanged: (value) {
        setState(() {
          db.setHemisphere(value);
        });
      }, title: Text("Northern Hemisphere"),)
    ],),);
  }
}