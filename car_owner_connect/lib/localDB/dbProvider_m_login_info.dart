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

  final scripts = {
    '2' : ['''alter table M_LOGIN_INFO add column LAST_LOGIN  timestamp'''],
    '3' : ['''alter table M_LOGIN_INFO add column CREATED_AT  timestamp'''],
    '4' : ['''alter table M_LOGIN_INFO add column UPDATED_AT  timestamp''']
  };

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "CaroConLocal.db");

    return await openDatabase(path, version: 4,
                              onCreate: createTable,
                              onUpgrade: upgradeTable);
  }

  Future<void> createTable(Database db, int version) async {
    return await db.execute(
      '''
      create table M_LOGIN_INFO (
        USERNAME  text  primary key,
        PASSWORD  text
      )
      '''
    );
  }

  Future<void> upgradeTable(Database db, int oldVersion, int newVersion) async{
    for (var i = oldVersion + 1; i <= newVersion; i++) {
      var queries = scripts[i.toString()];
      for (String query in queries) {
        await db.execute(query);
      }
    }
  }

  createLoginInfo(M_LOGIN_INFO loginInfo) async {
    final db = await database;
    var res = await db.insert(tableName, loginInfo.toMap());
    return res;
  }

  getAllLoginInfo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        DateTime lastLogin;
        try {
          lastLogin = DateTime.parse(maps[i]['LAST_LOGIN']);
        } catch(e) {
          lastLogin = null;
        }
        return M_LOGIN_INFO(
          username: maps[i]['USERNAME'],
          password: maps[i]['PASSWORD'],
          last_login: lastLogin,
        );
      });
    } else {
      return null;
    }
  }

  updateLoginInfo(M_LOGIN_INFO loginInfo) async {
    print(loginInfo.toMap());
    final db = await database;
    var res = await db.rawUpdate('''
      update
        M_LOGIN_INFO
      set
        password = '${loginInfo.password}'
      , last_login = CURRENT_TIMESTAMP
      , updated_at = CURRENT_TIMESTAMP
      where
        username = '${loginInfo.username}'
    ''');
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