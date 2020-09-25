import 'package:flutter/material.dart';
import '../import/header.dart';

class TalkMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: 'talk',),
      body: Container(
        child: TalkMainPage(),
        color: Colors.white,
      ),
    );
  }
}

class TalkMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          // search
          Container(
            constraints: BoxConstraints.expand(height: 25.0),
            padding: EdgeInsets.all(0),
            child: Text(
                '検索',
                style: TextStyle(
                    color: Colors.black,
                  fontSize: 18,
                )
            ),
            color: Colors.grey
          ),

          // history
          Container(
              constraints: BoxConstraints.expand(height: 25.0),
              padding: EdgeInsets.all(0),
              child: Text(
                  '履歴',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )
              ),
              color: Colors.grey
          ),

          SingleChildScrollView(

          ),
        ],
      )
    );
  }
}