import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../import/header.dart';
import '../import/footer.dart';

class TalkMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: 'talk',),
      body: Container(
        child: TalkMainPage(),
        color: Colors.lightBlue,
      ),
      bottomNavigationBar: Footer()
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
                fontSize: 18,
              )
            ),
            color: Colors.grey
          ),

          // 1行目：本拠、分類番号
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left:10.0, right:5.0, top:5.0, bottom:1.5),
                child: Text(
                  "本拠",
                  style: TextStyle(
                    fontSize: 15.0
                  ),
                ),
                height: 30.0,
                width: 60.0,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:5.0, right:5.0, top:5.0, bottom:1.5),
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
                        color: Colors.blue,
                        width: 3.0,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 15.0
                  )
                ),
                height: 30.0,
              ),),
              Container(
                padding: EdgeInsets.only(left:5.0, right:5.0, top:5.0, bottom:1.5),
                child: Text(
                  "分類番号",
                  style: TextStyle(
                    fontSize: 15.0
                  )
                ),
                height: 30.0,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:5.0, right:10.0, top:5.0, bottom:1.5),
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
                        color: Colors.blue,
                        width: 3.0,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 15.0
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(3),
                  ],
                ),
                height: 30.0,
              ),),
            ],
          ),

          // 2行目：色
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left:10.0, right:5.0, top:3.0, bottom:1.5),
                child: Text(
                  "色",
                  style: TextStyle(
                    fontSize: 15.0
                  )
                ),
                height: 30.0,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:5.0, right:10.0, top:3.0, bottom:1.5),
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
                        color: Colors.blue,
                        width: 3.0,
                      ),
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 15.0
                  )
                ),
                height: 30.0,
              ),),
            ],
          ),

          // 3行目：ひらがな、番号
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left:10.0, right:5.0, top:3.0, bottom:5.0),
                child: Text(
                  "ひらがな",
                  style: TextStyle(
                    fontSize: 15.0
                  )
                ),
                height: 30.0,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:5.0, right:5.0, top:3.0, bottom:5.0),
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
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: 15.0
                    )
                ),
                height: 30.0,
              ),),
              Container(
                padding: EdgeInsets.only(left:5.0, right:5.0, top:3.0, bottom:5.0),
                child: Text(
                  "番号",
                  style: TextStyle(
                    fontSize: 15.0
                  )
                ),
                height: 25,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:5.0, right:1.0, top:3.0, bottom:5.0),
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
                        color: Colors.blue,
                        width: 3.0,
                      ),
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 15.0
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(2),
                  ],
                ),
                height: 30.0,
              ),),
              Container(
                padding: EdgeInsets.only(left:0.0, right:0.0, top:3.0, bottom:5.0),
                child: Text(
                  "-",
                  style: TextStyle(
                    fontSize: 15.0
                  )
                ),
                height: 30.0,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(left:1.0, right:5.0, top:3.0, bottom:5.0),
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
                        color: Colors.blue,
                        width: 3.0,
                      ),
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 15.0
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(2),
                  ],
                ),
                height: 30.0,
              ),),

              // search button
              Container(
                padding: EdgeInsets.only(left:3.0, right:5.0, top:3.0, bottom:5.0),
                child: RaisedButton.icon(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  label: Text("検索"),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  onPressed: () {
                  },
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                ),
                height: 30.0,
              ),
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