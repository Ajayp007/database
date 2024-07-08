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
        String query =
            "CREATE TABLE cate (id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT)";
        db.execute(query);
        String query2 =
            "CREATE TABLE trans(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,amount TEXT,date TEXT,timeTEXT,category TEXT,status INTEGER)";
        db.execute(query2);
      },
    );
  }

  Future<void> insertCategoryDB(String category) async {
    db = await checkDB();
    String query = "INSERT INTO cate (category) VALUES ('$category')";
    db!.rawInsert(query);
  }

  Future<void> updateCategoryDB(String category, int index) async {
    db = await checkDB();
    String query = "UPDATE cate SET category = '$category' WHERE id = '$index'";
    db!.rawUpdate(query);
  }

  Future<void> deleteCategoryDB(int index) async {
    db = await checkDB();
    String query = "DELETE FROM cate WHERE id = '$index'";
    db!.rawDelete(query);
  }

  Future<List<Map>> readCategoryDB() async {
    db = await checkDB();
    String query = "SELECT * FROM cate";
    List<Map> l1 = await db!.rawQuery(query);
    return l1;
  }

  Future<void> insertProductDB(String name, String amount, String date,
      String time, String category, int status) async {
    db = await checkDB();
    String query =
        "INSERT INTO trans (category) VALUES ('$name','$amount','$date','$time','$category','$status')";
    db!.rawInsert(query);
  }

  void updateProductDB() {}

  void deleteProductDB() {}

  void readProductDB() {}
}
