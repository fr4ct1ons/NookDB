import 'package:flutter/cupertino.dart';
import 'package:nook_db/structs.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum CritterType { Bug, Fish, Creature }

Future<Database>? database;

Map<int, TrackedCritter> trackedCritters = {};

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
    return {'id': id, 'type': critterType, 'isTracked': tracked};
  }
}

Future<void> startDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
    join(await getDatabasesPath(), 'trackedCritters.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE trackedCritter(id INTEGER PRIMARY KEY, type INTEGER, isTracked INTEGER");
    },
  );
}

Future<void> trackCritter(Critter critter) async {
  TrackedCritter tracked = TrackedCritter();
  tracked.tracked = 1;
  tracked.id = critter.id;

  if (critter is Bug)
    tracked.critterType = CritterType.Bug;
  else if (critter is Fish)
    tracked.critterType = CritterType.Fish;
  else if (critter is Creature) tracked.critterType = CritterType.Creature;
  final db = await database;
  db!.insert('trackedCritter', tracked.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> stopTrackingCritter(Critter critter) async {
  TrackedCritter tracked = TrackedCritter();
  tracked.tracked = 0;
  tracked.id = critter.id;

  if (critter is Bug)
    tracked.critterType = CritterType.Bug;
  else if (critter is Fish)
    tracked.critterType = CritterType.Fish;
  else if (critter is Creature) tracked.critterType = CritterType.Creature;

  final db = await database;

  db!.delete('trackedCritter', where: 'id = ?', whereArgs: [critter.id]);
}

Future<void> getTracked() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db!.query('trackedCritter');

  List.generate(maps.length, (i) {
    return TrackedCritter(
        critterType: maps[i]['type'],
        id: maps[i]['id'],
        tracked: maps[i]['isTracked']);
  });
}
