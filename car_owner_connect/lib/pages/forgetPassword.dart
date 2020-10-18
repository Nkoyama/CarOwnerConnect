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
                child: Text(
                  "納車日"
                ),
                width: 90.0,
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: RaisedButton.icon(
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.blue,
                  ),
                  label: Text(deliveryDate),
                  onPressed: () => _selectDeliveryDate(context),
                ),
              ),
            ],
          ),

          // オーナーの生年月日
          Row(
            children: <Widget> [
              Container(
                padding: EdgeInsets.only(left:20.0, right: 10.0, top:10.0, bottom:10.0),
                child: Text(
                  "生年月日"
                ),
                width: 90.0,
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: RaisedButton.icon(
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.blue,
                  ),
                  label: Text(birthDate),
                  onPressed: () => _selectBirthDate(context),
                ),
              ),
            ],
          ),

          // よくドライブに行く場所
          Row(
            children: <Widget> [
              Container(
                padding: EdgeInsets.only(left:20.0, right: 10.0, top:10.0, bottom:10.0),
                child: Text(
                    "よくドライブに行く場所"
                ),
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0, bottom: 3.0),
                child: TextField(
                  decoration: InputDecoration(
                    //Focusしていないとき
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    //Focusしているとき
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(
                      fontSize: 15.0
                  ),
                ),
                height: 30.0,
              ),),
            ],
          )
        ]
      )
    );
  }
}