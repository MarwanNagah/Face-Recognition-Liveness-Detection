import 'package:face_liveness_detection_app/Screens/authenticate/homepage.dart';
import 'package:face_liveness_detection_app/Screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:face_liveness_detection_app/Screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showhomepage = true;
  bool showsignin = true;
  void toggleView() {
    setState(() => showhomepage = !showhomepage);
  }

  void toggleView2() {
    setState(() => showsignin = !showsignin);
  }

  @override
  Widget build(BuildContext context) {
    if (showhomepage) {
      return Homepage(toggleView: toggleView);
    } else {
      if (showsignin) {
        return SignIn(toggleView: toggleView2);
      } else {
        return Register(toggleView: toggleView2);
      }
    }
  }
}
