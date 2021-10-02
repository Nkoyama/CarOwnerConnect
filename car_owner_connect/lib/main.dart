import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'import/globalConstant.dart' as gc;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'import/header.dart';
import 'pages/createAccount.dart';
import 'pages/mainFooter.dart';
import 'pages/forgetPassword.dart';
import 'localDB/bloc_m_login_info.dart';
import 'localDB/m_login_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Scaffold(
        appBar: Header(headerText: 'sing in'),
        body: Container(
          child: SignInPage(),
          color: Colors.white,
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("ja"),
      ],
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // logo
          Container(
              padding: EdgeInsets.all(15),
              child: Image.asset('images/CaroCon_logo2.png')
          ),

          // username, password, sign in button
          Container(
            padding: EdgeInsets.all(10),
            child: SignInResult(title: ''),
          ),

          // create account button
          Container(
            child: FlatButton(
              child: Text("create account"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAccount(),
                    )
                );
              },
              textColor: Colors.blue,
              padding: EdgeInsets.only(left:20.0, right:20.0, top:20.0),
            ),
          ),

          // forget password button
          Container(
            child: FlatButton(
              textColor: Colors.blue,
              padding: EdgeInsets.only(left:20.0, right:20.0),
              child: Text("forget username or password?"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPassword(),
                    )
                );
              },
            ),
          ),
        ],
      )
    );
  }
}

class SignInResult extends StatefulWidget {
  SignInResult({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SignInState createState() => new SignInState();
}

class SignInState extends State<SignInResult> {
  String username = '';
  String password = '';

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  var _usernameFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();

  String savedUsername = '';
  String savedPassword = '';

  List<M_LOGIN_INFO> savedLoginUsers = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _usernameFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget> [

            // username textField
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Username',
                icon: Icon(Icons.account_circle),
              ),
              controller: _usernameController,
              autocorrect: false,
              autofocus: false,
              keyboardType: TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(20),
              ],
              obscureText: false,
              focusNode: _usernameFocusNode,
            ),

            // password textField
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
                icon: Icon(Icons.security),
              ),
              controller: _passwordController,
              autocorrect: false,
              autofocus: false,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(12),
              ],
              obscureText: true,
              focusNode: _passwordFocusNode,
            ),

            // sign in button
            Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton.icon(
                icon: Icon(
                  Icons.lock_open,
                  color: Colors.white,
                ),
                label: Text("sign in"),
                onPressed: () {
                  this.username = _usernameController.text;
                  this.password = _passwordController.text;
                  signIn();
                },
                color: Colors.lightGreen,
                textColor: Colors.white,
              ),
            ),
          ]
        ),
      ),
    );
  }

  /// ログイン画面描画直後に行う処理
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 端末内に保存されたログイン情報を取得
      Bloc_m_login_info blocMLoginInfo = Bloc_m_login_info();
      var savedLoginInfoList = blocMLoginInfo.getLoginInfo();
      savedLoginInfoList.then((loginInfo) {
        // 保存されたログイン情報の中で最後にログインしたユーザのログイン情報を自動で入力
        if (loginInfo is List<M_LOGIN_INFO>) {
          savedLoginUsers = loginInfo;
          int i = 0;
          var lastLoginTime;
          var lastLoginUsername;
          var lastLoginPassword;
          for(var li in loginInfo) {
            if(i == 0){
              lastLoginTime = li.last_login;
              lastLoginUsername = li.username;
              lastLoginPassword = li.password;
            } else {
              try {
                if(lastLoginTime == null || lastLoginTime.isBefore(li.last_login)) {
                  lastLoginTime = li.last_login;
                  lastLoginUsername = li.username;
                  lastLoginPassword = li.password;
                }
              } catch(e) {
                // 何もしない
              }
            }
            i++;
          }
          _usernameController.text = lastLoginUsername;
          _passwordController.text = lastLoginPassword;
          savedUsername = lastLoginUsername;
          savedPassword = lastLoginPassword;
        }
      });
    });
  }

  /// sign in
  void signIn() async{
    // ユーザー情報取得
    LoginInfoResponse loginInfoResponse;
    try {
      loginInfoResponse = await getLoginInfo();
    } catch(e) {
      //error message
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(e),
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

    // 入力チェック
    if(this.password == loginInfoResponse.returnPassword && loginInfoResponse.returnDelFlg == '0') {
      // 保存されたデータ内に一致するデータがあるか探す
      bool isSaved = false;
      for (var li in savedLoginUsers) {
        if (li.username == this.username) {
          isSaved = true;
          continue;
        }
      }
      // 保存済みデータが存在する場合 -> 更新
      if(isSaved) {
        // M_LOGIN_INFOをupdate
        final loginInfo = M_LOGIN_INFO(
          username: this.username,
          password: this.password,
          last_login: DateTime.now(),
          updated_at: DateTime.now(),
        );
        Bloc_m_login_info blocMLoginInfo = Bloc_m_login_info();
        blocMLoginInfo.update(loginInfo);
        print('M_LOGIN_INFO更新');
        // 画面遷移
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Main(),
          )
        );
      }
      // 保存されたデータと一致しない場合
      else {
        // 新しいログイン情報を保存
        final loginInfo = M_LOGIN_INFO(
          username: this.username,
          password: this.password,
          last_login: DateTime.now(),
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
        );
        Bloc_m_login_info blocMLoginInfo = Bloc_m_login_info();
        blocMLoginInfo.create(loginInfo);
        print('新規ログインデータ作成');
        // 画面遷移
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Main(),
            )
        );
      }
    } else {
      //error message
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text("UsernameまたはPasswordが登録されたユーザ情報を一致しません。"),
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
    // 画面遷移
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Main(),
        )
    );
  }

  // usernameをサーバーに送り、passwordとdel_flgが返ってくる
  Future<LoginInfoResponse> getLoginInfo() async {
    String url = gc.apiUrl + '/loginInfo/';
    Map<String, String> headers = {'Content-type': 'application/json'};
    Map<String, dynamic> body = {'username': this.username};
    http.Response resp = await http.post(url, headers: headers, body: json.encode(body));
    if(resp.statusCode == 200) {
      return new LoginInfoResponse.fromJson(json.decode(resp.body));
    } else {
      print(resp.statusCode);
      throw "ログイン情報の取得に失敗しました。";
    }
  }
}

class LoginInfoResponse {
  String returnUsername;
  String returnPassword;
  String returnDelFlg;

  LoginInfoResponse([
    this.returnUsername,
    this.returnPassword,
    this.returnDelFlg
  ]);

  LoginInfoResponse.fromJson(Map<String,dynamic> json) :
    returnUsername = json['username'],
    returnPassword = json['password'],
    returnDelFlg = json['del_flg'];
}
