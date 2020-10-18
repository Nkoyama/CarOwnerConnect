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
      body: Container(

      ),
      bottomNavigationBar: BottomAppBar(
        child: Expanded(child: Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              //Focusしていないとき
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              //Focusしているとき
              focusedBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(
                fontSize: 15.0
            ),
          ),
          height: 50.0,
        ),),
      ),
    );
  }
}