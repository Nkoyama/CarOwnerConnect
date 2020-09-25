import 'package:flutter/material.dart';
import 'import/header.dart';
import 'pages/createAccount.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Scaffold(
        appBar: Header(headerText: 'sing in'),
        body: Container(
          child: SignIn(),
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
          Container(
              padding: EdgeInsets.all(15),
              child: Image.asset('images/CaroCon_logo1.png')
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
            child: RaisedButton.icon(
              icon: Icon(
                Icons.lock_open,
                color: Colors.white,
              ),
              label: Text("sign in"),
              onPressed: () {
              },
              color: Colors.lightGreen,
              textColor: Colors.white,
            ),
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
              padding: EdgeInsets.only(left:20.0, right:20.0),
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
