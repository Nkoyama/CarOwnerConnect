import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../import/header.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'talkPage.dart';

class TalkMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: 'talk',),
      body: Container(
        child: TalkMainPage(),
        color: Colors.lightBlueAccent,
      ),
    );
  }
}

class TalkMainPage extends StatefulWidget {
  TalkMainPage({Key key}) : super(key: key);

  @override
  TalkMainPageState createState() => new TalkMainPageState();
}

class TalkMainPageState extends State<TalkMainPage> {
  List<String> colorList = [
    "色を選択してください。",
    "白(文字色：緑)",
    "緑(文字色：白)",
    "黄色(文字色：黒)",
    "黒(文字色：黄色)"
  ];
  String selectedColor = "色を選択してください。";

  var _placeController = TextEditingController();
  var _classificationController = TextEditingController();
  var _colorController = TextEditingController();
  var _hiraganaController = TextEditingController();
  var _numberController_1 = TextEditingController();
  var _numberController_2 = TextEditingController();

  var _placeFocusNode = FocusNode();
  var _classificationFocusNode = FocusNode();
  var _colorFocusNode = FocusNode();
  var _hiraganaFocusNode = FocusNode();
  var _numberFocusNode_1 = FocusNode();
  var _numberFocusNode_2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget> [

          /* search */
          Container(
              constraints: BoxConstraints.expand(height: 25.0),
              padding: EdgeInsets.only(left: 5, right: 5),
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
                padding: EdgeInsets.only(
                    left: 10.0, right: 5.0, top: 5.0, bottom: 1.5),
                child: Text(
                  "本拠",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0
                  ),
                ),
                height: 30.0,
                width: 60.0,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 1.5),
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
                  focusNode: _placeFocusNode,
                  controller: _placeController,
                ),
                height: 30.0,
              ),),
              Container(
                padding: EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 5.0, bottom: 1.5),
                child: Text(
                    "分類番号",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    )
                ),
                height: 30.0,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(
                    left: 5.0, right: 10.0, top: 5.0, bottom: 1.5),
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
                  focusNode: _classificationFocusNode,
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
                padding: EdgeInsets.only(
                    left: 10.0, right: 5.0, top: 3.0, bottom: 1.5),
                child: Text(
                    "色",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    )
                ),
                height: 30.0,
                width: 60.0,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 5.0, right: 10.0, top: 3.0, bottom: 1.5),
                height: 30.0,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 10.0, top: 1.0, bottom: 1.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                  ),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedColor,
                      onChanged: (String newValue) {
                        setState(() {
                          selectedColor = newValue;
                        });
                      },
                      selectedItemBuilder: (context) {
                        return colorList.map((String item) {
                          return Text(
                            item,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                          );
                        }).toList();
                      },
                      items: colorList.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: item == selectedColor
                                ? TextStyle(fontWeight: FontWeight.bold)
                                : TextStyle(fontWeight: FontWeight.normal),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ),
            ],
          ),

          // 3行目：ひらがな、番号
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 10.0, right: 5.0, top: 3.0, bottom: 5.0),
                child: Text(
                    "ひらがな",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    )
                ),
                height: 33.5,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 3.0, bottom: 5.0),
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
                    focusNode: _hiraganaFocusNode,
                ),
                height: 33.5,
              ),),
              Container(
                padding: EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 3.0, bottom: 5.0),
                child: Text(
                    "番号",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    )
                ),
                height: 33.5,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(
                    left: 5.0, right: 1.0, top: 3.0, bottom: 5.0),
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
                  focusNode: _numberFocusNode_1,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(2),
                  ],
                ),
                height: 33.5,
              ),),
              Container(
                padding: EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 3.0, bottom: 5.0),
                child: Text(
                    "-",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    )
                ),
                height: 33.5,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.only(
                    left: 1.0, right: 5.0, top: 3.0, bottom: 5.0),
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
                  focusNode: _numberFocusNode_2,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(2),
                  ],
                ),
                height: 33.5,
              ),),

              // search button
              Container(
                padding: EdgeInsets.only(
                    left: 3.0, right: 5.0, top: 3.0, bottom: 5.0),
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
                  onPressed: () {},
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                ),
                height: 33.5,
              ),
            ],
          ),

          /* history */
          Container(
            constraints: BoxConstraints.expand(height: 25.0),
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
                '履歴',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )
            ),
            color: Colors.grey
          ),

          new Expanded(
            child: TalkHistory(),
          ),
        ],
      ),
      backgroundColor: Colors.lightBlueAccent,
    );
  }
}

class TalkHistory extends StatefulWidget {
  TalkHistory({Key key}) : super(key: key);

  @override
  TalkHistoryState createState() => new TalkHistoryState();
}

class TalkHistoryState extends State<TalkHistory> {
  static const historyData = [
    "品川 300 む ･2-17",
    "bbb",
    "ccc",
    "ddd",
    "eee",
    "fff",
    "ggg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, int index) {
          return Padding(
            padding: EdgeInsets.all(0.0),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.20,
              child: Container(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    historyData[index],
                  ),
                  subtitle: Text("サブタイトル"),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TalkPage(
                          opponentText: historyData[index]
                        )
                      ),
                    ),
                  },
                ),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  color: Colors.black45,
                  iconWidget: Text(
                    "非表示",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => {}, // _showSnackBar('More'),
                ),
                IconSlideAction(
                  color: Colors.red,
                  iconWidget: Text(
                    "削除",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => {}, // _showSnackBar('Delete'),
                ),
              ],
            )
          );
        },
      )
    );
  }
}