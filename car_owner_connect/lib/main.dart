import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // <- Debug の 表示を OFF
      home: Scaffold(
        appBar: AppBar(title: Text("sign in"),),
        body: Center(child: Text("オラオラオラオラ")),
      ),
    );
  }
}
