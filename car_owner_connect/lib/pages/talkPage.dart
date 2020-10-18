import 'package:flutter/material.dart';
import '../import/header.dart';

class TalkPage extends StatelessWidget {
  String opponentText;
  TalkPage({String opponentText}) {
    this.opponentText = opponentText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: opponentText),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Expanded(
            child: new SingleChildScrollView(

            ),
          ),
          new Container(
            color: Colors.white,
            padding: new EdgeInsets.all(10.0),
            child: new TextField(
              decoration: new InputDecoration(
                hintText: 'message',
              ),
            ),
          ),
        ],
      ),
    );
  }
}