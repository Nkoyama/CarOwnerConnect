import 'package:flutter/material.dart';
import '../import/header.dart';

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: 'forget password',),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(

              ),
            ],
          )
        )
      )
    );
  }
}