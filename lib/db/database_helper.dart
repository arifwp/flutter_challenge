import 'package:flutter/cupertino.dart';
import 'package:flutter_challenge/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static Database? _db;

  static const String dbName = 'flutter.db';
  static const String tableUser = 'user';
  static const int dbVersion = 1;
  static const String userID = 'user_id';
  static const String userName = 'user_name';
  static const String userEmail = 'email';
  static const String userPassword = 'password';

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
        "CREATE TABLE $tableUser ($userID INT PRIMARY KEY AUTOINCREMENT NOT NULL, $userName TEXT, $userEmail TEXT, $userPassword TEXT)");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableUser, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
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
