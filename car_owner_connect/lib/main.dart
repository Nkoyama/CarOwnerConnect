import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'import/header.dart';
import 'pages/createAccount.dart';
import 'pages/mainFooter.dart';
import 'pages/forgetPassword.dart';
import 'localDB/bloc_m_login_info.dart';
import 'localDB/m_login_info.dart';

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
        // 保存されたログイン情報を自動で入力
        if (loginInfo is List<M_LOGIN_INFO>) {
          _usernameController.text = loginInfo[0].username;
          _passwordController.text = loginInfo[0].password;
          savedUsername = loginInfo[0].username;
          savedPassword = loginInfo[0].password;
        }
      });
    });
  }

  /// sign in
  void signIn() {
    // 入力チェック
    if(this.username.length > 0 && this.password.length > 0) {
      // UsernameとPasswordが保存されたデータと一致する
      if(savedUsername == this.username && savedPassword == this.password) {
        print('ログインデータ変更なし');
        // 画面遷移のみ
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Main(),
            )
        );
      }
      // Usernameのみ保存されたデータの場合
      else if(savedUsername == this.username) {
        // Passwordをupdate
        final loginInfo = M_LOGIN_INFO(
            username: this.username,
            password: this.password
        );
        Bloc_m_login_info blocMLoginInfo = Bloc_m_login_info();
        blocMLoginInfo.update(loginInfo);
        print('Password更新');
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
            password: this.password
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
            content: Text("UsernameまたはPasswordが入力されていません。"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }
}
