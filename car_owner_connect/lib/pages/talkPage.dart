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

      )
    );
  }
}