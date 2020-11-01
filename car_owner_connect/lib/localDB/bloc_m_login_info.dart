import 'dart:async';
import 'm_login_info.dart';
import 'dbProvider_m_login_info.dart';

class Bloc_m_login_info {
  final loginInfoController = StreamController<List<M_LOGIN_INFO>>();
  Stream<List<M_LOGIN_INFO>> get loginInfoStream => loginInfoController.stream;

  getLoginInfo() async {
    loginInfoController.sink.add(await DBProvider_m_login_info.db.getAllLoginInfo());
  }

  Bloc_m_login_info() {
    getLoginInfo();
  }

  dispose() {
    loginInfoController.close();
  }

  create(M_LOGIN_INFO m_login_info) {
    DBProvider_m_login_info.db.createLoginInfo(m_login_info);
    getLoginInfo();
  }

  update(M_LOGIN_INFO m_login_info) {
    DBProvider_m_login_info.db.updateLoginInfo(m_login_info);
    getLoginInfo();
  }
  
  delete(String username) {
    DBProvider_m_login_info.db.deleteLoginInfo(username);
    getLoginInfo();
  }
}
