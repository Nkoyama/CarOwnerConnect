import 'dart:async';
import 'm_login_info.dart';
import 'dbProvider_m_login_info.dart';

class Bloc_m_login_info {
  final loginInfoController = StreamController<List<M_LOGIN_INFO>>();
  Stream<List<M_LOGIN_INFO>> get loginInfoStream => loginInfoController.stream;

  getLoginInfo() async {
    loginInfoController.sink.add(await DBProvider_m_login_info.db.getAllLoginInfo());
    return await DBProvider_m_login_info.db.getAllLoginInfo();
  }

  Bloc_m_login_info() {
    getLoginInfo();
  }

  dispose() {
    loginInfoController.close();
  }

  create(M_LOGIN_INFO loginInfo) {
    DBProvider_m_login_info.db.createLoginInfo(loginInfo);
    getLoginInfo();
  }

  update(M_LOGIN_INFO loginInfo) {
    DBProvider_m_login_info.db.updateLoginInfo(loginInfo);
    getLoginInfo();
  }
  
  delete(String username) {
    DBProvider_m_login_info.db.deleteLoginInfo(username);
    getLoginInfo();
  }
}
