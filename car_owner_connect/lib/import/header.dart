import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget{
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final String headerText;
  Header({this.headerText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.headerText,),
      backgroundColor: Color.fromARGB(255, 111, 207, 151),
      centerTitle: true,
      elevation: 0.0,
    );
  }
}