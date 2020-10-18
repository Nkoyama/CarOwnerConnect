import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../import/header.dart';

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: 'forget password',),
      body: Container(
        child: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                    "以下の秘密の質問に答えてください。"
                ),
              ),
              Container(
                child: SecretQuestion(),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "万が一、秘密の質問の答えが分からない場合は、公式TwitterのDMにてご相談ください。",
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  child: Text("公式Twitter"),
                  color: Colors.lightBlue,
                  shape: StadiumBorder(),
                  onPressed: () {
                    launchTwitter();
                  },
                ),
              ),
            ],
          )
        )
      )
    );
  }

  void launchTwitter() async {
    const url = 'https://www.google.com/';
    if (!(await canLaunch(url))) {
    } else {
      await launch(url);
    }
  }
}

class SecretQuestion extends StatefulWidget {
  SecretQuestion({Key key}) : super(key: key);

  @override
  SecretQuestionState createState() => new SecretQuestionState();
}

class SecretQuestionState extends State<SecretQuestion> {
  var deliveryDate = "納車日を選択してください。";
  var birthDate = "生年月日を選択してください。";
  String favoriteDriveSpot = '';
  var _favoriteSpotController = TextEditingController();
  var _favoriteSpotFocusNode = FocusNode();

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
    return SingleChildScrollView(
      child: Column(
        children: <Widget> [
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
                  label: Text(deliveryDate),
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
                  label: Text(birthDate),
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

          // decide button
          Container(
            padding: EdgeInsets.all(10.0),
            child: RaisedButton.icon(
              icon: Icon(
                Icons.directions_car,
                color: Colors.black,
              ),
              label: Text("決定"),
              shape: StadiumBorder(),
              onPressed: () => _secretQuestionSubmit(),
              color: Color.fromARGB(255, 111, 207, 151),
            ),
          ),
        ]
      )
    );
  }

  /// 秘密の質問「決定」ボタンタップ時の処理
  /// * 秘密の質問をサーバに送信し、結果を受け取る
  void _secretQuestionSubmit() {
    /* 入力チェック */
    //納車日
    if(deliveryDate == "納車日を選択してください。" || deliveryDate.isEmpty) {
      //error message
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
//            title: Text("必須項目エラー"),
            content: Text("納車日を選択してください。"),
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
    //生年月日
    if(birthDate == "生年月日を選択してください。" || birthDate.isEmpty) {
      //error message
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
//            title: Text("必須項目エラー"),
            content: Text("生年月日を選択してください。"),
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
    //よくドライブに行く場所
    favoriteDriveSpot = _favoriteSpotController.text;
    if(favoriteDriveSpot == "" || favoriteDriveSpot.isEmpty) {
      //error message
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
//            title: Text("必須項目エラー"),
            content: Text("よくドライブに行く場所を入力してください。"),
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
    /* 入力チェック完了 */
  }
}