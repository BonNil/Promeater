import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:promeater/models/protein.dart';
import 'package:promeater/style_variables.dart';

class ProteinProvider {
  factory ProteinProvider() {
    return _dbHelper;
  }

  ProteinProvider._internal();
  static final ProteinProvider _dbHelper = ProteinProvider._internal();

  String tblProtein = 'protein';
  String colId = 'id';
  String colTitle = 'title';
  String colCurrent = 'current';
  String colMaximum = 'maximum';
  String colColor = 'color';
  String colShow = 'show';

  static Database _db;

  Future<Database> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = dir.path + 'promeater.db';

    final dbProteins =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return dbProteins;
  }

  void _createDb(Database db, int newVersion) {
    db.execute(
        'CREATE TABLE $tblProtein($colId INTEGER PRIMARY KEY, $colTitle TEXT, $colCurrent INTEGER, $colMaximum INTEGER, $colColor INTEGER, $colShow INTEGER)');

    db.insert(tblProtein, Protein(StylingVariables.redMeatColor, 'Red Meat', 0, 1).toMap());
    db.insert(tblProtein, Protein(StylingVariables.poultryColor, 'Poultry', 0, 1).toMap());
    db.insert(tblProtein, Protein(StylingVariables.seafoodColor, 'Seafood', 0, 1).toMap());
    db.insert(tblProtein, Protein(StylingVariables.vegetarianColor, 'Vegetarian', 0, 1).toMap());
    db.insert(tblProtein, Protein(StylingVariables.veganColor, 'Vegan', 0, 1).toMap());
  }

  Future<int> insertProtein(Protein protein) async {
    final Database db = await this.db;
    final result = await db.insert(tblProtein, protein.toMap());
    return result;
  }

  Future<List> getProteins() async {
    final List<Protein> proteins = <Protein>[];
    final Database db = await this.db;
    final result =
        await db.rawQuery('SELECT * FROM $tblProtein order by $colId ASC');
    for (int i = 0; i < result.length; i++) {
      proteins.add(Protein.fromObject(result[i]));
    }

    return proteins;
  }

  Future<Protein> getProtein(String title) async {
    final Database db = await this.db;
    final result = await db.rawQuery(
        'SELECT DISTINCT * FROM $tblProtein WHERE $colTitle = $title');
    return Protein.fromObject(result);
  }

  Future<int> getCount() async {
    final Database db = await this.db;
    final result = Sqflite.firstIntValue(
        await db.rawQuery('select count (*) from $tblProtein'));
    return result;
  }

  Future<int> updateProtein(Protein protein) async {
    final Database db = await this.db;
    final result = await db.update(tblProtein, protein.toMap(),
        where: '$colId = ?', whereArgs: <int>[protein.id]);
    return result;
  }

  Future<int> deleteProtein(int id) async {
    int result;
    final Database db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblProtein WHERE $colId = $id');
    return result;
  }
}
