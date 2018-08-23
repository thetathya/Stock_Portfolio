import 'package:flutter/material.dart';
import 'Home.dart';
import 'Login.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyHomePage(),
    routes: <String, WidgetBuilder> {
      "/Homepage": (BuildContext context) => new Homepage()
    }
  ));
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}*/
