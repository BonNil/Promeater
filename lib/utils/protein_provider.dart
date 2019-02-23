import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:promeater/models/protein.dart';
import 'package:promeater/utils/db_initializer.dart';

class ProteinProvider {
  factory ProteinProvider() {
    return _dbHelper;
  }

  ProteinProvider._internal();
  static final ProteinProvider _dbHelper = ProteinProvider._internal();

  static String tblProtein = 'protein';
  static String colId = 'id';
  static String colTitle = 'title';
  static String colCurrent = 'current';
  static String colMaximum = 'maximum';
  static String colColor = 'color';
  static String colShow = 'show';

  static Database _db;

  Future<Database> get db async {
    _db ??= await DatabaseInitializer.initializeDb();
    return _db;
  }

  Future<int> insertProtein(Protein protein) async {
    final Database db = await this.db;
    final result = await db.insert(tblProtein, protein.toMap());
    return result;
  }

  Future<List<Protein>> getProteins() async {
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
