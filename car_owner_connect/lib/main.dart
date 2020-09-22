import 'package:flutter/material.dart';
import 'import/header.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Header(),
        body: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
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
                  autofocus: true,
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
            padding: EdgeInsets.all(20),
            child: RaisedButton.icon(
              icon: Icon(
                Icons.lock_open,
                color: Colors.white,
              ),
              label: Text("sign in"),
              onPressed: () {},
              color: Colors.lightGreen,
              textColor: Colors.white,
            ),
          ),

          // create account button
          Container(
            child: FlatButton(
              child: Text("create account"),
              onPressed: () {},
              textColor: Colors.blue,
              padding: EdgeInsets.only(left:20.0, right:20.0),
            ),
          ),

          // forget password button
          Container(
            child: FlatButton(
              child: Text("forget password?"),
              onPressed: () {},
              textColor: Colors.blue,
              padding: EdgeInsets.only(left:20.0, right:20.0),
            ),
          ),
        ],
      ),
    );
  }
}