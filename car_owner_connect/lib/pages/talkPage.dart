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
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () => {},
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}