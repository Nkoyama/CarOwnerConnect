import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'm_login_info.dart';

class DBProvider_m_login_info {
  DBProvider_m_login_info._();
  static final DBProvider_m_login_info db = DBProvider_m_login_info._();
  static final tableName = "M_LOGIN_INFO";

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // DBがなかったら作る
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "CaroConLocal.db");

    return await openDatabase(path, version: 1, onCreate: createTable);
  }

  Future<void> createTable(Database db, int version) async {
    return await db.execute(
      '''
      create table M_LOGIN_INFO (
        USERNAME  text  primary key,
        PASSWORD  text
      '''
    );
  }

  createLoginInfo(M_LOGIN_INFO loginInfo) async {
    final db = await database;
    var res = await db.insert(tableName, loginInfo.toMap());
    return res;
  }

  getAllLoginInfo() async {
    final db = await database;
    var res = await db.query(tableName);
    List<M_LOGIN_INFO> loginInfoList = res.isNotEmpty ? res.map((c)
        => M_LOGIN_INFO.fromMap(c)).toList() : [];
    return loginInfoList;
  }

  updateLoginInfo(M_LOGIN_INFO loginInfo) async {
    final db = await database;
    var res = await db.update(
      tableName,
      loginInfo.toMap(),
      where: "username = ?",
      whereArgs: [loginInfo.username]
    );
    return res;
  }

  deleteLoginInfo(String username) async {
    final db = await database;
    var res = await db.delete(
      tableName,
      where: "username = ?",
      whereArgs: [username]
    );
    return res;
  }
}