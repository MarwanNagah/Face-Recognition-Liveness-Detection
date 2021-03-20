import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:face_liveness_detection_app/result.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  String url='http://10.0.2.2:5000/';

  Future getResult() async {
    var data = await getData(url);
    var decodedData = jsonDecode(data);
    print(decodedData['query']);
  }

  MyApp(){
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FaceDetect(),
      theme: ThemeData.dark(),
    );
  }
}