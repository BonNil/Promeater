import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:promeater/models/AppStatus.dart';
import 'package:promeater/utils/dbCreator.dart';

class AppStatusProvider {
  factory AppStatusProvider() {
    return _dbHelper;
  }

  AppStatusProvider._internal();
  static final AppStatusProvider _dbHelper = AppStatusProvider._internal();

  static String tblStatus = 'status';
  static String colId = 'id';
  static String colResetWeek = 'resetWeek';

  static Database _db;

  Future<Database> get db async {
    _db ??= await DbCreator.initializeDb();
    return _db;
  }

  Future<int> insertAppStatus(AppStatus status) async {
    final Database db = await this.db;
    final result = await db.insert(tblStatus, status.toMap());
    return result;
  }

  Future<AppStatus> getAppStatus() async {
    final Database db = await this.db;
    final result = await db.rawQuery(
        'SELECT DISTINCT * FROM $tblStatus ORDER BY $colId LIMIT 1');
    return AppStatus.fromObject(result[0]);
  }

  Future<int> updateAppStatus(AppStatus status) async {
    final Database db = await this.db;
    final result = await db.update(tblStatus, status.toMap(),
        where: '$colId = ?', whereArgs: <int>[status.id]);
    return result;
  }
}
