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
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _password2Controller = TextEditingController();

  var _usernameFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  var _password2FocusNode = FocusNode();

  var deliveryDate = "納車日を選択してください。";
  var birthDate = "生年月日を選択してください。";
  String favoriteDriveSpot = '';
  var _favoriteSpotController = TextEditingController();

  Future<void> _selectDeliveryDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: DateTime(2015),
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
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    obscureText: false,
                    focusNode: _passwordFocusNode,
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
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    obscureText: false,
                    focusNode: _password2FocusNode,
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
                    controller: _favoriteSpotController,
                    style: TextStyle(
                        fontSize: 15.0
                    ),
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
  }
}
