import 'package:flutter/material.dart';
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

              // new username textField
              Container(
                padding: EdgeInsets.only(right:20, left:20),
                child: Column(
                  children: <Widget>[

                    // username textField
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'new username',
                        hintText: 'mew username',
                        icon: Icon(Icons.account_circle),
                      ),
                      autocorrect: false,
                      autofocus: false,
                      keyboardType: TextInputType.text,
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
            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}