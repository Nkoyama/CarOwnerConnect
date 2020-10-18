import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'import/header.dart';
import 'pages/createAccount.dart';
import 'pages/mainFooter.dart';
import 'pages/forgetPassword.dart';

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
                  username = _usernameController.text;
                  password = _passwordController.text;
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

  void signIn() {
    if(this.username.length > 0 && this.password.length > 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Main(),
          )
      );
    } else {
      //error message
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
//            title: Text("sign in error"),
            content: Text("サインインに失敗しました。\nUsernameとPasswordを確認してください。"),
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
