import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:promeater/utils/protein_provider.dart';
import 'package:promeater/utils/app_status_provider.dart';
import 'package:promeater/models/protein.dart';
import 'package:promeater/style_variables.dart';
import 'package:promeater/utils/date_helper.dart';

class DatabaseInitializer {
  static final String _createAppStatusTblQuery =
      'CREATE TABLE IF NOT EXISTS ${AppStatusProvider.tblStatus}(${AppStatusProvider.colId} ' +
          'INTEGER PRIMARY KEY, ${AppStatusProvider.colResetWeek} INTEGER)';

  static final String _createProteinTblQuery =
      'CREATE TABLE IF NOT EXISTS ${ProteinProvider.tblProtein}(${ProteinProvider.colId} ' +
          'INTEGER PRIMARY KEY, ${ProteinProvider.colTitle} TEXT, ${ProteinProvider.colCurrent} ' +
          'INTEGER, ${ProteinProvider.colMaximum} INTEGER, ${ProteinProvider.colColor} INTEGER, ' +
          '${ProteinProvider.colShow} INTEGER)';

  static Future<Database> initializeDb() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = dir.path + 'promeater.db';

    final db = await openDatabase(path,
        version: 1, onCreate: DatabaseInitializer.createDb);
    await _ensureTablesAndInitialValues(db);

    return db;
  }

  static void createDb(Database db, int newVersion) {
    db.execute(_createAppStatusTblQuery);
    _createAppStatus(db);

    db.execute(_createProteinTblQuery);
    _createProteins(db);
  }

  static Future<void> _ensureTablesAndInitialValues(Database db) async {
    await _createTableIfNotExists(db, AppStatusProvider.tblStatus,
        _createAppStatusTblQuery, _createAppStatus);
    await _createTableIfNotExists(db, ProteinProvider.tblProtein,
        _createProteinTblQuery, _createProteins);
  }

  static void _createAppStatus(Database db) {
    db.insert(AppStatusProvider.tblStatus, <String, dynamic>{
      AppStatusProvider.colResetWeek: weekNumber(DateTime.now())
    });
  }

  static void _createProteins(Database db) {
    db.insert(ProteinProvider.tblProtein,
        Protein(StylingVariables.redMeatColor, 'Beef', 0, 1).toMap());
    db.insert(ProteinProvider.tblProtein,
        Protein(StylingVariables.porkColor, 'Pork', 0, 1).toMap());
    db.insert(ProteinProvider.tblProtein,
        Protein(StylingVariables.poultryColor, 'Poultry', 0, 1).toMap());
    db.insert(ProteinProvider.tblProtein,
        Protein(StylingVariables.seafoodColor, 'Seafood', 0, 1).toMap());
    db.insert(ProteinProvider.tblProtein,
        Protein(StylingVariables.vegetarianColor, 'Vegetarian', 0, 1).toMap());
    db.insert(ProteinProvider.tblProtein,
        Protein(StylingVariables.veganColor, 'Vegan', 0, 1).toMap());
  }

  static Future<void> _createTableIfNotExists(
      Database db, String tblName, String tblQuery, Function onCreate) async {
    final tables = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type="table" AND name="$tblName"');

    if (tables.isEmpty) {
      await db.execute(tblQuery);
      onCreate(db);
    }
  }
}
