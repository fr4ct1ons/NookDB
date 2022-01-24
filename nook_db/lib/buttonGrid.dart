import 'package:flutter/material.dart';

class ButtonGrid extends StatefulWidget {
  const ButtonGrid({Key? key}) : super(key: key);

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
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            OutlinedButton(onPressed: () {}, child: Text('Critters')),
            OutlinedButton(onPressed: () {}, child: Text('Art')),
            OutlinedButton(onPressed: () {}, child: Text('Items')),
            OutlinedButton(onPressed: () {}, child: Text('Villagers')),
            OutlinedButton(onPressed: () {}, child: Text('Fossils')),
            OutlinedButton(onPressed: () {}, child: Text('Clothing')),
          ],
        ),
      ),
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
