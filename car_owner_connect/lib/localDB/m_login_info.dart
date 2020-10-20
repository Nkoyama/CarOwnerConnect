class M_LOGIN_INFO {
  String username;
  String password;

  M_LOGIN_INFO({this.username, @required this.password});
  M_LOGIN_INFO.newTodo() {
    username = "";
    password = "";
  }

  factory M_LOGIN_INFO.fromMap(Map<String, dynamic> json) => M_LOGIN_INFO(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "username": username,
    "password": password,
  };
}