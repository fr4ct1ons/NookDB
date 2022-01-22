import 'package:flutter/material.dart';

class AvailableCritters extends StatefulWidget {
  const AvailableCritters({Key? key}) : super(key: key);

  @override
  _AvailableCrittersState createState() => _AvailableCrittersState();
}

class _AvailableCrittersState extends State<AvailableCritters> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Available critters"),
        SizedBox(
          height: 100,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 8, crossAxisSpacing: 8),
            itemCount: 10,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) {
              return RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Colors.yellow,
                shape: CircleBorder(),
                padding: EdgeInsets.all(8),
                child: Image(
                  image: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/1864/1864557.png"),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

/*
shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(180.0),
                            side: BorderSide(color: Colors.red))),
                  )
 */
