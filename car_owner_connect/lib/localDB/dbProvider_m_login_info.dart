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
    _database = await initM_LOGIN_INFO();
    return _database;
  }

  Future<Database> initM_LOGIN_INFO() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "CaroConLocal.db");

    return await openDatabase(path, version: 1, onCreate: createM_LOGIN_INFO);
  }

  Future<void> createM_LOGIN_INFO(Database db, int version) async {
    return await db.execute(
      '''
      create table M_LOGIN_INFO (
        USERNAME  text  primary key,
        PASSWORD  text
      '''
    );
  }

  createLoginInfo(M_LOGIN_INFO m_login_info) async {
    final db = await database;
    var res = await db.insert(tableName, m_login_info.toMap());
    return res;
  }

  getAllLoginInfo() async {
    final db = await database;
    var res = await db.query(tableName);
    List<M_LOGIN_INFO> loginInfoList = res.isNotEmpty ? res.map((c)
        => M_LOGIN_INFO.fromMap(c)).toList() : [];
    return loginInfoList;
  }

  updateLoginInfo(M_LOGIN_INFO m_login_info) async {
    final db = await database;
    var res = await db.update(
      tableName,
      m_login_info.toMap(),
      where: "username = ?",
      whereArgs: [m_login_info.username]
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