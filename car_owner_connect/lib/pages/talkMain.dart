import 'package:flutter/material.dart';
import '../import/header.dart';

class TalkMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: 'talk',),
      body: Container(
        child: TalkMainPage(),
        color: Colors.lightBlue,
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

          /* search */
          Container(
            constraints: BoxConstraints.expand(height: 25.0),
            padding: EdgeInsets.only(left:5, right:5),
            child: Text(
              '検索',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              )
            ),
            color: Colors.grey
          ),

          Row(
            children: [
              Expanded(child: Container(
                padding: EdgeInsets.only(left:10.0, right:10.0, top:3.0, bottom:1.5),
                child: Text("本拠"),
                height: 25,
                color: Colors.lightBlue,
              ),),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:10.0, right:10.0, top:3.0, bottom:1.5),
                child: TextField(
                  style: TextStyle(
                    fontSize: 15.0
                  )
                ),
                height: 25.0,
              ),),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:10.0, right:10.0, top:3.0, bottom:1.5),
                child: Text("分類番号"),
                height: 25,
                color: Colors.lightBlue,
              ),),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:10.0, right:10.0, top:3.0, bottom:1.5),
                child: TextField(
                  style: TextStyle(
                    fontSize: 15.0
                  ),
                  keyboardType: TextInputType.number,
                ),
                height: 25.0,
              ),),
            ],
          ),

          Row(
            children: [
              Expanded(child: Container(
                padding: EdgeInsets.only(left:10.0, right:10.0, top:3.0, bottom:1.5),
                child: Text("色"),
                height: 25,
                color: Colors.lightBlue,
              ),),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:10.0, right:10.0, top:3.0, bottom:1.5),
                child: TextField(
                    style: TextStyle(
                        fontSize: 15.0
                    )
                ),
                height: 25.0,
              ),),
            ],
          ),

          /* history */
          Container(
            constraints: BoxConstraints.expand(height: 25.0),
            padding: EdgeInsets.only(left:5, right:5),
            child: Text(
              '履歴',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
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