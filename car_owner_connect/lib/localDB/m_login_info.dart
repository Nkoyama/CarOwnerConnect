class M_LOGIN_INFO {
  String username;
  String password;

  M_LOGIN_INFO({this.username, this.password});
  M_LOGIN_INFO.newLoginInfo() {
    username = "";
    password = "";
  }

  factory M_LOGIN_INFO.fromMap(Map<String, dynamic> json) {
    return M_LOGIN_INFO(
      username: json["username"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password,
    };
  }
}