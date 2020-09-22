import 'package:flutter/material.dart';
import '../import/header.dart';

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: 'create account',),
      body: Container(
        height: double.infinity,
        color: Colors.red,
      ),
    );
  }
}