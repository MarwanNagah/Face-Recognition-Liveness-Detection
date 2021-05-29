import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:face_liveness_detection_app/main.dart';
import 'package:face_liveness_detection_app/Screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:face_liveness_detection_app/Models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Nav(
        loggedUser: user,
      );
    }
  }
}
