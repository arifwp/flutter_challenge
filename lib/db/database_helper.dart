import 'package:flutter/cupertino.dart';
import 'package:flutter_challenge/models/activity_model.dart';
import 'package:flutter_challenge/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static Database? _db;

  static const String dbName = 'flutter.db';
  static const String tableUser = 'user';
  static const String tableActivity = 'activity';
  static const int dbVersion = 1;
  static const String userID = 'user_id';
  static const String userName = 'user_name';
  static const String userEmail = 'email';
  static const String userPassword = 'password';
  static const String activityId = 'activity_id';
  static const String activityName = 'activity_name';
  static const String activityDate = 'date';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, dbName);
    var db =
        await openDatabase(path, version: dbVersion, onCreate: onCreateFunc);
    return db;
  }

  onCreateFunc(Database db, int intVersion) async {
    await db.execute(
        "CREATE TABLE $tableUser ($userID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $userName TEXT, $userEmail TEXT, $userPassword TEXT)");
    await db.execute(
        "CREATE TABLE $tableActivity ($activityId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $activityName TEXT, $activityDate TEXT)");
  }

  Future<int> saveActivity(ActivityModel activity) async {
    var dbClient = await db;
    print(' ini get activity dari database helper');
    print(activity.activity_name);
    var res = await dbClient.insert(
      tableActivity,
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<List<ActivityModel>> getActivity() async {
    var dbClient = await db;
    List<Map<String, dynamic>> usersMaps = await dbClient.query(tableActivity);
    return List.generate(usersMaps.length, (index) {
      return ActivityModel(
        usersMaps[index]['activity_id'],
        usersMaps[index]['activity_name'],
        usersMaps[index]['date'],
      );
    });
    // List<Map<String, dynamic>> list =
    //     await dbClient.rawQuery("SELECT * FROM $tableActivity");
    // return list.map((activity) => ActivityModel.fromMap(activity)).toList();
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    var res = await dbClient.insert(
      tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<User?> getUserLogin(String username, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableUser WHERE "
        "$userName = '$username' AND "
        "$userPassword = '$password'");
    if (res.length > 0) {
      return User.fromMap(res.first);
    }

    return null;
  }
}
