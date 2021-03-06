import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../import/header.dart';

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: 'create account',),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // logo
              Container(
                  padding: EdgeInsets.all(15),
                  child: Image.asset('images/CaroCon_logo2.png')
              ),

              // create account button
              Container(
                padding: EdgeInsets.all(10),
                child: CreateAccountResult(title: ''),
              ),

            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}

class CreateAccountResult extends StatefulWidget {
  CreateAccountResult({Key key, this.title}) : super(key: key);
  final String title;

  @override
  CreateAccountState createState() => new CreateAccountState();
}

class CreateAccountState extends State<CreateAccountResult> {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _password2Controller = TextEditingController();

  var _usernameFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  var _password2FocusNode = FocusNode();

  String createAccountMessage = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _usernameFocusNode.unfocus();
        _passwordFocusNode.unfocus();
        _password2FocusNode.unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget> [

            // new username textField
            Container(
              padding: EdgeInsets.only(right:20, left:20),
              child: Column(
                children: <Widget>[

                  // username textField
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'username',
                      hintText: 'mew username',
                      icon: Icon(Icons.account_circle),
                    ),
                    autocorrect: false,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    obscureText: false,
                    focusNode: _usernameFocusNode,
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      '　　　※半角',
                      textAlign: TextAlign.left,
                    ),
                  ]),
                ],
              ),
            ),

            // password textField
            Container(
              padding: EdgeInsets.only(right:20, left:20),
              child: Column(
                children: <Widget>[

                  // username textField
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'password',
                      hintText: 'password',
                      icon: Icon(Icons.security),
                    ),
                    autocorrect: false,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    obscureText: false,
                    focusNode: _passwordFocusNode,
                  ),

                  TextField(
                    decoration: InputDecoration(
                      labelText: 'password again',
                      hintText: 'password',
                      icon: Icon(Icons.security),
                    ),
                    autocorrect: false,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    obscureText: false,
                    focusNode: _password2FocusNode,
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
                label: Text("create account"),
                onPressed: () {
                  createAccount();
                },
                color: Colors.lightGreen,
                textColor: Colors.white,
              ),
            ),

            Container(
              padding: EdgeInsets.all(0),
              child: Text(
                createAccountMessage,
                style: TextStyle(
                    color: Colors.red
                )
              ),
            )
          ]
        ),
      ),
    );
  }

  void createAccount() {
    if(this.createAccountMessage.length > 0) {
      setState(() {
        this.createAccountMessage = "";
      });
    } else {
      setState(() {
        this.createAccountMessage = "failed to create account.";
      });
    }
  }
}
