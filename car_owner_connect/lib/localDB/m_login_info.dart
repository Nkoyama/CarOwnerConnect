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
    String createdAt = "";
    if(created_at is DateTime) {
      createdAt = created_at.year.toString() + "-"
                + created_at.month.toString() + "-"
                + created_at.day.toString() + " "
                + created_at.hour.toString() + ":"
                + created_at.minute.toString() + ":"
                + created_at.second.toString();
    }
    return {
      "username": username,
      "password": password,
      "last_login": last_login.year.toString() + "-"
                  + last_login.month.toString() + "-"
                  + last_login.day.toString() + " "
                  + last_login.hour.toString() + ":"
                  + last_login.minute.toString() + ":"
                  + last_login.second.toString(),
      "created_at": createdAt,
      "updated_at": updated_at.year.toString() + "-"
                  + updated_at.month.toString() + "-"
                  + updated_at.day.toString() + " "
                  + updated_at.hour.toString() + ":"
                  + updated_at.minute.toString() + ":"
                  + updated_at.second.toString(),
    };
  }
}