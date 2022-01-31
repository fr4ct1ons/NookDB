import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:nook_db/structs.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

enum CritterType { Bug, Fish, Creature }

Future<Database>? database;

Map<int, TrackedCritter> trackedFish = {};
Map<int, TrackedCritter> trackedBug = {};
Map<int, TrackedCritter> trackedCreature = {};

SharedPreferences? prefs;
bool isNorthernHemisphere = true;
Map<int, bool> trackedTasks = {};

class TrackedCritter {
  int tracked = 0;
  CritterType critterType = CritterType.Bug;
  int id = 0;

  TrackedCritter(
      {this.id = 0, this.tracked = 0, this.critterType = CritterType.Bug});

  bool isTracked() {
    return tracked == 1;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'type': critterType.index, 'isTracked': tracked};
  }
}

Future<void> getPreferences() async
{
  prefs =  await SharedPreferences.getInstance();
  
  if(prefs!.containsKey("isNorthernHemisphere"))
  {
    isNorthernHemisphere = prefs!.getBool("isNorthernHemisphere")!;
  }

  DateTime date;

  if(prefs!.containsKey("lastOpenedDate"))
  {
    date = DateTime.parse(prefs!.getString("lastOpenedDate")!);
    DateTime now = DateTime.now();
    if(date.day != now.day)
    {
      prefs!.setString('lastOpenedDate', now.toString());
      prefs!.setStringList('tasks', []);
    }
  }
  else
  {
    prefs!.setString('lastOpenedDate', DateTime.now().toString());
  }

  if(prefs!.containsKey("tasks"))
  {
    List<String> tasks = prefs!.getStringList("tasks")!;
    for (var task in tasks) {
      int number = int.parse(task.substring(1));
      if(task[0] == '1')
      {
        trackedTasks[number] = true;
      }
      else
      {
        trackedTasks[number] = false;
      }
    }
  }
}

void saveTasks()
{
  var temp = trackedTasks.entries.toList();
  List<String> toSave = [];
  for (var item in temp) {
    toSave.add("${item.value? 1 : 0}${item.key}");
  }
  prefs!.setStringList("tasks", toSave);
}

void setHemisphere(bool isNorth)
{
  isNorthernHemisphere = isNorth;

  prefs!.setBool("isNorthernHemisphere", isNorthernHemisphere);
}

Future<void> startDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(join(await getDatabasesPath(), 'trackedCritters.db'),
      onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE trackedCritter(id INTEGER PRIMARY KEY, type INTEGER, isTracked INTEGER)");
  }, version: 1);
}

Future<void> trackCritter(Critter critter) async {
  TrackedCritter tracked = TrackedCritter();
  tracked.tracked = 1;
  tracked.id = critter.id;

  if (critter is Bug) {
    tracked.critterType = CritterType.Bug;
    trackedBug[tracked.id] = tracked;
  } else if (critter is Fish) {
    tracked.critterType = CritterType.Fish;
    trackedFish[tracked.id] = tracked;
  } else if (critter is Creature) {
    tracked.critterType = CritterType.Creature;
    trackedCreature[tracked.id] = tracked;
  }
  final db = await database;
  db!.insert('trackedCritter', tracked.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> stopTrackingCritter(Critter critter) async {
  TrackedCritter tracked = TrackedCritter();
  tracked.tracked = 0;
  tracked.id = critter.id;

  if (critter is Bug) {
    tracked.critterType = CritterType.Bug;
    trackedBug.remove(critter.id);
  } else if (critter is Fish) {
    tracked.critterType = CritterType.Fish;
    trackedFish.remove(critter.id);
  } else if (critter is Creature) {
    tracked.critterType = CritterType.Creature;
    trackedCreature.remove(critter.id);
  }

  final db = await database;

  db!.delete('trackedCritter', where: 'id = ?', whereArgs: [critter.id]);
}

Future<void> getTracked() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db!.query('trackedCritter');

  var temp = List.generate(maps.length, (i) {
    return TrackedCritter(
        critterType: CritterType.values[maps[i]['type']],
        id: maps[i]['id'],
        tracked: maps[i]['isTracked']);
  });

  for (var i = 0; i < temp.length; i++) {
    var element = temp[i];
    switch (element.critterType) {
      case CritterType.Bug:
        trackedBug[element.id] = element;
        break;
      case CritterType.Fish:
        trackedFish[element.id] = element;
        break;
      case CritterType.Creature:
        trackedCreature[element.id] = element;
        break;
      default:
    }
  }
}
