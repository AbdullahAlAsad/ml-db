// import 'dart:async';
// import 'package:admin/models/TweeterProfile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';


// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._getInstance();
//   static Database? _database;

//   DatabaseHelper._getInstance();

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'output.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//          await rootBundle.load('output.db');
//       },
//     );
//   }

//   Future<List<TweeterProfile>> getTweeterProfiles() async {
//     final db = await database;
//     db.rawQuery('select sqlite_version();').then(print);
//     List<Map<String, dynamic>> tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
//     debugPrint(tables.length.toString());
//     tables.forEach((element) {
//       print(element.toString());
//      });
//     final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM tweet_profile');
//     // await db.query('tweet_profile');
//     return List.generate(maps.length, (i) {
//       return TweeterProfile.fromJson(maps[i]);
//     });
//   }

//   Future<List<TweeterProfile>> getTweeterProfilesByVerified(bool verified) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'tweet_profile',
//       where: 'verified = ?',
//       whereArgs: [verified ? 'true' : 'false'],
//     );
//     return List.generate(maps.length, (i) {
//       return TweeterProfile.fromJson(maps[i]);
//     });
//   }

// }
