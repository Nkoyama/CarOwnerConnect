import 'dart:async';
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