import 'package:flutter_application_1/adduser.dart';
import 'package:flutter_application_1/admin.dart';

import 'edituser.dart';
import 'home.dart';
import 'signin.dart';
import 'signup.dart';
import 'admin.dart';
import "package:flutter/material.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home: HomePage());
  }
}
