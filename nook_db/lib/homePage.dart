import 'package:flutter/material.dart';
import 'package:nook_db/availableCritters.dart';
import 'package:nook_db/buttonGrid.dart';
import 'todoList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'Villager';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text("NookDB"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            SizedBox(height: 15),
            TodoList(),
            ButtonGrid(),
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
            AvailableCritters()
          ],
        ),
      ),
    );
  }
}
