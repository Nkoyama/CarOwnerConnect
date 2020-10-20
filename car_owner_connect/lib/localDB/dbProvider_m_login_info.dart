import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider_m_login_info {
  DBProvider_m_login_info._();
  static final DBProvider_m_login_info db = DBProvider_m_login_info._();

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
}