// import 'package:sqflite/sqflite.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:promeater/models/protein.dart';

// class DbHelper {
//   static final DbHelper _dbHelper = DbHelper._internal();
//   String tblProtein = "protein";
//   String colId = "id";
//   String colTitle = "title";
//   String colCurrent = "current";
//   String colMaximum = "maximum";

//   DbHelper._internal();

//   factory DbHelper() {
//     return _dbHelper;
//   }

//   static Database _db;

//   Future<Database> get db async {
//     if (_db == null) {
//       _db = await initializeDb();
//     }
//     return _db;
//   }

//   Future<Database> initializeDb() async {
//     Directory dir = await getApplicationDocumentsDirectory();
//     String path = dir.path + "promeater.db";
    
//     var dbProteins = await openDatabase(path, version: 1, onCreate: _createDb); 
//     return dbProteins;
//   }

//   void _createDb(Database db, int newVersion) async {
//     await db.execute(
//       "CREATE TABLE $tblProtein($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
//         "$colCurrent INTEGER, $colMaximum INTEGER)");
//     await insertProtein(new Protein("Red Meat", 0, 1));
//     await insertProtein(new Protein("Poultry", 0, 1));
//     await insertProtein(new Protein("Seafood", 0, 1));
//     await insertProtein(new Protein("Vegetarian", 0, 1));
//     await insertProtein(new Protein("Vegan", 0, 1));
//   }

//   Future<int> insertProtein(Protein protein) async {
//     Database db = await this.db;
//     var result = await db.insert(tblProtein, protein.toMap());
//     return result;
//   }

//   Future<List> getProteins() async {
//     Database db = await this.db;
//     var result = await db.rawQuery("SELECT * FROM $tblProtein order by $colTitle ASC");
//     return result;
//   }

//   Future<Protein> getProtein(String title) async {
//     Database db = await this.db;
//     var result = await db.rawQuery("SELECT DISTINCT * FROM $tblProtein WHERE $colTitle = $title");
//     return Protein.fromObject(result);
//   }

//   Future<int> getCount() async {
//     Database db = await this.db;
//     var result = Sqflite.firstIntValue(
//       await db.rawQuery("select count (*) from $tblProtein")
//     );
//     return result;
//   }

//   Future<int> updateProtein(Protein protein) async {
//     var db = await this.db;
//     var result = await db.update(tblProtein, protein.toMap(),
//       where: "$colId = ?", whereArgs: [protein.id]);
//     return result;
//   }

//   Future<int> deleteProtein(int id) async {
//     int result;
//     var db = await this.db;
//     result = await db.rawDelete('DELETE FROM $tblProtein WHERE $colId = $id');
//     return result;
//   }
// }
