import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nook_db/availableCritters.dart';
import 'package:nook_db/buttonGrid.dart';
import 'package:nook_db/configPage.dart';
import 'package:nook_db/structs.dart';
import 'todoList.dart';
import 'package:http/http.dart' as http;
import 'database.dart' as db;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'Villager';
  Widget availableCritters = Text("Loading critters...");
GlobalKey<AvailableCrittersState> acKey = GlobalKey();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    availableCritters = AvailableCritters(key: acKey,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text("NookDB"),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) {
            return ConfigPage();
          },)).then((value) {
            print("Refreshing");
            setState(() {
              acKey.currentState?.refreshCritters();
            });
          });
        }, icon: Icon(Icons.menu))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            TodoList(),
            ButtonGrid( onReturnFromCritterSearch: () {acKey.currentState!.refreshCritters();},),
            SizedBox(
              height: 7,
            ),
            Text(
              "Available critters",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 7,
            ),
            availableCritters
          ],
        ),
      ),
    );
  }
}
