import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? db;

  Future<Database?> checkDB() async {
    if (db != null) {
      return db;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Ajay.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE ajay (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)");
      },
    );
  }

  Future<void> insertDB(String category) async {
    db = await checkDB();

    String query = "INSERT INTO ajay (name) VALUES ('$category')";
    db!.rawInsert(query);
  }

  void updateDB() {}

  void deleteDB() {}

  void readDB() {}
}
