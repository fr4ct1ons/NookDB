import 'package:flutter/material.dart';
import 'package:nook_db/homePage.dart';
//import 'package:splashscreen/splashscreen.dart';
import 'database.dart' as db;
import 'helper/populateDatabase.dart' as loader;



class CustomSplashscreen extends StatefulWidget {
  const CustomSplashscreen({ Key? key }) : super(key: key);

  @override
  _CustomSplashscreenState createState() => _CustomSplashscreenState();
}

class _CustomSplashscreenState extends State<CustomSplashscreen> {

  String currentStatus = "Loading saved data";

  Future<void> loadData() async
  {
    await db.startDatabase();
    await db.getTracked();
    await db.getPreferences();

    _updateStatus("Fetching bugs");
    await loader.getBugs();
    _updateStatus("Fetching fishes");
    await loader.getFish();
    _updateStatus("Fetching sea creatures");
    await loader.getSeaCreatures();
    _updateStatus("Fetching items");
    await loader.getItems();
    await loader.getItemsWall();
    await loader.getItemsMisc();
    _updateStatus("Fetching art pieces");
    await loader.getArt();
    _updateStatus("Fetching fossils");
    await loader.getFossils();
    _updateStatus("Fetching villagers");
    await loader.getVillagers();
    _updateStatus("Done!");

    print("Finished loading data");
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (ctx, a1, a2) {
      return HomePage();
    }, transitionDuration: Duration(milliseconds: 2000),
    transitionsBuilder:(context, animation, secondaryAnimation, child) =>
      FadeTransition(opacity: animation, child: child,)
    ,));
  }

  void _updateStatus(String text)
  {
    setState(() {
      currentStatus = text;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(child: Column(children: [
        Text("NookDB", style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),),
        SizedBox(height: 16,),
      Text(currentStatus, style: TextStyle(color: Colors.white, fontSize: 16.0))],
      mainAxisAlignment: MainAxisAlignment.center,)),
    );
  }

    
}