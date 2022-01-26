import 'package:flutter/cupertino.dart';
import 'package:nook_db/structs.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum CritterType { Bug, Fish, Creature }

Future<Database>? database;

Map<int, TrackedCritter> trackedFish = {};
Map<int, TrackedCritter> trackedBug = {};
Map<int, TrackedCritter> trackedCreature = {};

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
