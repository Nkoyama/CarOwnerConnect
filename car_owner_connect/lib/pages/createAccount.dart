import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../import/header.dart';

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: 'create account',),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // logo
              Container(
                  padding: EdgeInsets.only(left:15.0, right:15.0, top:15.0),
                  child: Image.asset('images/CaroCon_logo2.png')
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: CreateAccountResult(),
              ),

            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}

class CreateAccountResult extends StatefulWidget {
  CreateAccountResult({Key key}) : super(key: key);

  @override
  CreateAccountState createState() => new CreateAccountState();
}

class CreateAccountState extends State<CreateAccountResult> {
  var _usernameFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  var _password2FocusNode = FocusNode();
  var _favoriteDriveLocationFocusNode = FocusNode();

  String username = "";
  String password = "";
  String password_check = "";
  var deliveryDate = "納車日を選択してください。";
  var birthDate = "生年月日を選択してください。";
  String favoriteDriveLocation = '';

  Future<void> _selectDeliveryDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: new DateTime.now(),
      locale: const Locale("ja"),
    );
    if (selected != null) {
      setState(() {
        initializeDateFormatting("ja_JP");
        var formatter = new DateFormat('yyyy/MM/dd', "ja_JP");
        deliveryDate = formatter.format(selected);
      });
    }
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: new DateTime.now(),
      locale: const Locale("ja"),
    );
    if (selected != null) {
      setState(() {
        initializeDateFormatting("ja_JP");
        var formatter = new DateFormat('yyyy/MM/dd', "ja_JP");
        birthDate = formatter.format(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _usernameFocusNode.unfocus();
        _passwordFocusNode.unfocus();
        _password2FocusNode.unfocus();
        _favoriteDriveLocationFocusNode.unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget> [

            // new username textField
            Container(
              padding: EdgeInsets.only(right:20, left:20),
              child: Column(
                children: <Widget>[

                  // username textField
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'username',
                      hintText: 'mew username',
                      icon: Icon(Icons.account_circle),
                    ),
                    autocorrect: false,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    obscureText: false,
                    focusNode: _usernameFocusNode,
                    onChanged: (String newValue) {
                      setState(() {
                        username = newValue;
                      });
                    },
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      '　　　※半角',
                      textAlign: TextAlign.left,
                    ),
                  ]),
                ],
              ),
            ),

            // password textField
            Container(
              padding: EdgeInsets.only(right:20, left:20),
              child: Column(
                children: <Widget>[

                  // password textField
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'password',
                      hintText: 'password',
                      icon: Icon(Icons.security),
                    ),
                    autocorrect: false,
                    autofocus: false,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    obscureText: false,
                    focusNode: _passwordFocusNode,
                    onChanged: (String newValue) {
                      setState(() {
                        password = newValue;
                      });
                    },
                  ),

                  // password again textField
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'password again',
                      hintText: 'password',
                      icon: Icon(Icons.security),
                    ),
                    autocorrect: false,
                    autofocus: false,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    obscureText: false,
                    focusNode: _password2FocusNode,
                    onChanged: (String newValue) {
                      setState(() {
                        password_check = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),

            /* 秘密の質問 */
            Container(
              padding: EdgeInsets.only(top:20.0, bottom:5.0, left:10.0, right:10.0),
              child: Text(
                  "以下の秘密の質問に答えてください。"
              ),
            ),

            // 納車日
            Row(
              children: <Widget> [
                Container(
                  padding: EdgeInsets.only(left:20.0, right: 10.0, top:10.0, bottom:10.0),
                  child: Text("納車日"),
                  width: 90.0,
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.date_range,
                      color: Colors.black,
                    ),
                    label: Text(
                      deliveryDate,
                      style: TextStyle(
                        fontSize: 12.0
                      )
                    ),
                    onPressed: () => _selectDeliveryDate(context),
                    color: Color.fromARGB(255, 150, 255, 200),
                  ),
                ),
              ],
            ),

            // オーナーの生年月日
            Row(
              children: <Widget> [
                Container(
                  padding: EdgeInsets.only(left:20.0, right: 10.0, top:10.0, bottom:10.0),
                  child: Text("生年月日"),
                  width: 90.0,
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.date_range,
                      color: Colors.black,
                    ),
                    label: Text(
                      birthDate,
                      style: TextStyle(
                        fontSize: 12.0
                      ),
                    ),
                    onPressed: () => _selectBirthDate(context),
                    color: Color.fromARGB(255, 150, 255, 200),
                  ),
                ),
              ],
            ),

            // よくドライブに行く場所
            Row(
              children: <Widget> [
                Container(
                  padding: EdgeInsets.only(left:20.0, right: 10.0, top:10.0, bottom:10.0),
                  child: Text("よくドライブに行く場所"),
                ),
                Expanded(child: Container(
                  padding: EdgeInsets.only(left: 5.0, right: 10.0, top: 10.0, bottom: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      //Focusしているとき
                      focusedBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 150, 255, 200),
                    ),
                    style: TextStyle(
                        fontSize: 15.0
                    ),
                    focusNode: _favoriteDriveLocationFocusNode,
                    onChanged: (String newValue) {
                      setState(() {
                        favoriteDriveLocation = newValue;
                      });
                    },
                  ),
                  height: 50.0,
                ),),
              ],
            ),

            // sign in button
            Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton.icon(
                icon: Icon(
                  Icons.directions_car,
                  color: Colors.white,
                ),
                label: Text("create account"),
                onPressed: () {
                  createAccount();
                },
                color: Colors.lightGreen,
                textColor: Colors.white,
              ),
            ),

          ]
        ),
      ),
    );
  }

  void createAccount() {
    // check username
    var usernameRegExp = new RegExp(r'^[0-9a-zA-Z_]*$');
    if (username.isEmpty || username == null || username == "") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(""),
            content: Text("usernameが入力されていません。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    } else if(!usernameRegExp.hasMatch(username)) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(""),
            content: Text("usernameに使用できない文字が含まれています。\n半角英数字と'_'のみ使用できます。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }

    // check password
    var passwordRegExp = new RegExp(r'^[0-9a-zA-Z_]*$');
    if (password.isEmpty || password == null || password == "") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(""),
            content: Text("パスワードが入力されていません。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    } else if(!passwordRegExp.hasMatch(password)) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(""),
            content: Text("パスワードに使用できない文字が含まれています。\n半角英数字と'_'のみ使用できます。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    } else if(password != password_check) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(""),
            content: Text("パスワードが確認用パスワードと一致しません。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }

    // check delivery date
    if(deliveryDate.isEmpty || deliveryDate == null || deliveryDate == ""
      || deliveryDate == "納車日を選択してください。") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(""),
            content: Text("納車日が入力されていません。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }

    // check birth date
    if(birthDate.isEmpty || birthDate == null || birthDate == ""
      || birthDate == "生年月日を選択してください。") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(""),
            content: Text("生年月日が入力されていません。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }

    // check favorite drive location
    if(favoriteDriveLocation.isEmpty || favoriteDriveLocation == null || favoriteDriveLocation == "") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(""),
            content: Text("よくドライブに行く場所が入力されていません。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }
  }
}
