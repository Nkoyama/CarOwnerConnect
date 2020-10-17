import 'dart:async';
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

  Future<void> _selectDeliveryDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: new DateTime.now(),
    );
    if (selected != null) {
      setState(() {
        deliveryDate = (DateFormat.yMMMd()).format(selected);
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
                padding: EdgeInsets.only(left:10.0, right: 5.0, top: 10.0, bottom: 10.0),
                child: Text(
                  "納車日"
                )
              ),
              Container(
                padding: EdgeInsets.only(left:10.0, right: 5.0, top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 111, 207, 151), width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  deliveryDate
                ),
                width: 200.0,
              ),
              IconButton(
                padding: EdgeInsets.only(left:5.0, right: 10.0, top: 10.0, bottom: 10.0),
                icon: Icon(Icons.date_range),
                onPressed: () => _selectDeliveryDate(context),
              ),
            ],
          )
        ]
      )
    );
  }
}