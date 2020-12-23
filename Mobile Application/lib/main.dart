import 'package:face/home.dart';
import 'package:face/signin.dart';
import 'package:face/signup.dart';
import "package:flutter/material.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home: HomePage());
  }
}
