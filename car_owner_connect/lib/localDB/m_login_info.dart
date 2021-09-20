class M_LOGIN_INFO {
  String username;
  String password;
  DateTime last_login;
  DateTime created_at;
  DateTime updated_at;

  M_LOGIN_INFO({this.username, this.password, this.last_login, this.created_at, this.updated_at});
  M_LOGIN_INFO.newLoginInfo() {
    username = "";
    password = "";
    last_login = DateTime.now();
    created_at = DateTime.now();
    updated_at = DateTime.now();
  }

  factory M_LOGIN_INFO.fromMap(Map<String, dynamic> json) {
    return M_LOGIN_INFO(
      username: json["username"],
      password: json["password"],
      last_login: json["last_login"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password,
      "last_login": last_login,
      "created_at": created_at,
      "updated_at": updated_at,
    };
  }
}