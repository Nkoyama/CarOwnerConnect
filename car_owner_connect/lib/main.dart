import 'package:flutter/material.dart';
import 'import/header.dart';
import 'pages/createAccount.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        appBar: Header(headerText: 'sing in'),
        body: Container(
          child: SignIn(),
          color: Colors.white,
        ),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
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

          Container(
            padding: EdgeInsets.only(right:20, left:20),
            child: Column(
              children: <Widget>[

                // username textField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Username',
                    icon: Icon(Icons.account_circle),
                  ),
                  autocorrect: false,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                ),

                // password textField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',
                    icon: Icon(Icons.security),
                  ),
                  autocorrect: false,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
              ],
            ),
          ),

          // sign in button
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
              onPressed: () {},
              textColor: Colors.blue,
              padding: EdgeInsets.only(left:20.0, right:20.0),
              child: Text("forget username or password?"),
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
  String signInMessage = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget> [
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
                changeMessage();
              },
              color: Colors.lightGreen,
              textColor: Colors.white,
            ),
          ),

          Container(
            padding: EdgeInsets.all(0),
            child: Text(
              signInMessage,
              style: TextStyle(
                color: Colors.red
              )
            ),
          )
        ]
      ),
    );
  }

  void changeMessage() {
    if(this.signInMessage.length > 0) {
      setState(() {
        this.signInMessage = "";
      });
    } else {
      setState(() {
        this.signInMessage = "failed to sign in.";
      });
    }
  }
}
