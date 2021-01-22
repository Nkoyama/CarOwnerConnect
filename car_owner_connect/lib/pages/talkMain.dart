import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../import/header.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'talkPage.dart';
import 'package:http/http.dart' as http;

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
  List<String> placeList = [
    "本拠選択"
  ];

  List<String> colorList = [
    "色を選択してください。",
    "白(文字色：緑)",
    "緑(文字色：白)",
    "黄色(文字色：黒)",
    "黒(文字色：黄色)"
  ];

  List<String> numberList_1 = [
    "",
    "••", "•1", "•2", "•3", "•4", "•5", "•6", "•7", "•8", "•9",
    "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
    "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
    "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
    "40", "41", "42", "43", "44", "45", "46", "47", "48", "49",
    "50", "51", "52", "53", "54", "55", "56", "57", "58", "59",
    "60", "61", "62", "63", "64", "65", "66", "67", "69", "60",
    "70", "71", "72", "73", "74", "75", "76", "77", "78", "79",
    "80", "81", "82", "83", "84", "85", "86", "87", "88", "89",
    "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"
  ];
  List<String> numberList_2 = [
    "",
    "•1", "•2", "•3", "•4", "•5", "•6", "•7", "•8", "•9",
    "01", "02", "03", "04", "05", "06", "07", "08", "09",
    "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
    "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
    "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
    "40", "41", "42", "43", "44", "45", "46", "47", "48", "49",
    "50", "51", "52", "53", "54", "55", "56", "57", "58", "59",
    "60", "61", "62", "63", "64", "65", "66", "67", "69", "60",
    "70", "71", "72", "73", "74", "75", "76", "77", "78", "79",
    "80", "81", "82", "83", "84", "85", "86", "87", "88", "89",
    "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"
  ];

  String selectedPlace = "本拠選択";
  String classificationNumber = "";
  String selectedColor = "色を選択してください。";
  String hiragana = "";
  String selectedNumber_1 = "";
  String selectedNumber_2 = "";

  var _classificationController = TextEditingController();
  var _hiraganaController = TextEditingController();

  var _classificationFocusNode = FocusNode();
  var _hiraganaFocusNode = FocusNode();

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
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(
                        left: 5.0, right: 10.0, top: 3.0, bottom: 1.5),
                    height: 30.0,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 5.0, right: 0.0, top: 1.0, bottom: 1.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black),
                      ),
                      child: new DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedPlace,
                          onChanged: (String newValue) {
                            setState(() {
                              selectedPlace = newValue;
                            });
                          },
                          selectedItemBuilder: (context) {
                            return placeList.map((String item) {
                              return Text(
                                item,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              );
                            }).toList();
                          },
                          items: placeList.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: item == selectedPlace
                                    ? TextStyle(fontWeight: FontWeight.bold)
                                    : TextStyle(fontWeight: FontWeight.normal),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                ),
              ),
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
              Container(
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
                  onChanged: (String newValue) {
                    setState(() {
                      classificationNumber = newValue;
                      classificationNumber = classificationNumber.toUpperCase();
                    });
                  },
                  focusNode: _classificationFocusNode,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(3),
                  ],
                ),
                height: 30.0,
                width: 75.0,
              ),
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
                      left: 5.0, right: 0.0, top: 1.0, bottom: 1.0),
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
                    "平仮名",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    )
                ),
                height: 33.5,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 3.0, right: 3.0, top: 3.0, bottom: 5.0),
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
                    onChanged: (String newValue) {
                      setState(() {
                        hiragana = newValue;
                      });
                    },
                    focusNode: _hiraganaFocusNode,
                ),
                height: 33.5,
                width: 50.0,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 5.0, right: 0.0, top: 3.0, bottom: 5.0),
                child: Text(
                    "番号",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    )
                ),
                height: 33.5,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 5.0, right: 1.0, top: 3.0, bottom: 5.0),
                  height: 33.5,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 5.0, right: 0.0, top: 1.0, bottom: 1.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                    ),
                    child: new DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedNumber_1,
                        onChanged: (String newValue) {
                          setState(() {
                            selectedNumber_1 = newValue;
                          });
                        },
                        selectedItemBuilder: (context) {
                          return numberList_1.map((String item) {
                            return Text(
                              item,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            );
                          }).toList();
                        },
                        items: numberList_1.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: item == selectedNumber_1
                                  ? TextStyle(fontWeight: FontWeight.bold)
                                  : TextStyle(fontWeight: FontWeight.normal),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ),
              ),
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 1.0, right: 5.0, top: 3.0, bottom: 5.0),
                  height: 33.5,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 5.0, right: 0.0, top: 1.0, bottom: 1.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                    ),
                    child: new DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedNumber_2,
                        onChanged: (String newValue) {
                          setState(() {
                            selectedNumber_2 = newValue;
                          });
                        },
                        selectedItemBuilder: (context) {
                          return numberList_2.map((String item) {
                            return Text(
                              item,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            );
                          }).toList();
                        },
                        items: numberList_2.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: item == selectedNumber_2
                                  ? TextStyle(fontWeight: FontWeight.bold)
                                  : TextStyle(fontWeight: FontWeight.normal),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ),
              ),

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
                  onPressed: () {
                    search();
                  },
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

  void search() {
    // check place
    if(selectedPlace == "本拠選択" || selectedPlace == "") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不足"),
            content: Text("本拠が選択されていません"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }

    // check classification number
    var classificationNumberRegExp = new RegExp(r'^[1-9][A-Z0-9][A-Z0-9]?$');
    var zenkakuRegExp = new RegExp(r'[０-９Ａ-Ｚ]');
    if(classificationNumber == "") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不足"),
            content: Text("分類番号が入力されていません"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    } else if(!classificationNumberRegExp.hasMatch(classificationNumber)) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不正"),
            content: Text("分類番号が不正です。\n半角2~3桁で入力してください"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }

    // check color
    if(selectedColor == "色を選択してください。" || selectedColor == "") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不足"),
            content: Text("色が選択されていません"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }

    // check hiragana
    var hiraganaRegExp = new RegExp(r'^[あ-ん]$');
    if(hiragana == "") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不足"),
            content: Text("平仮名が入力されていません。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    } else if(!hiraganaRegExp.hasMatch(hiragana)) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不正"),
            content: Text("平仮名が不正です。平仮名1文字だけ入力してください。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    } else if(hiragana == "お" || hiragana == "し" || hiragana == "へ" || hiragana == "ん") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不正"),
            content: Text("平仮名が不正です。「お」「し」「へ」「ん」はナンバープレートに使用されていません。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }

    // check number
    if(selectedNumber_1 == "" || selectedNumber_2 == "") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不足"),
            content: Text("番号が選択されていません"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    } else if(selectedNumber_1 != "••" && selectedNumber_2.substring(0, 1) == "•") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不正"),
            content: Text("上2桁が「••」以外の場合に下2桁に「•」で始まる番号を指定することはできません"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    } else if(selectedNumber_1 == "••" && selectedNumber_2.substring(0, 1) == "0") {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("検索条件不正"),
            content: Text("上2桁が「••」の場合に下2桁に「0」で始まる番号を指定することはできません"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      return;
    }
  }

  void getPlaceList() async {
    http.get('http://160.16.217.34/api/placeList/').then((response) {
      setState(() {
        placeList = response.body.toString().split(', ');
        if(placeList.length > 0) {
          placeList.insert(0, "本拠選択");
        } else {
          placeList = ["error"];
        }
      });
    });
  }

  @override
  void initState() {
    getPlaceList();
    super.initState();
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