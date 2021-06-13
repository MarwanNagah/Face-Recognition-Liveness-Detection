import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          //     child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     CircularProgressIndicator(),
          //     Text(
          //       'Please wait...',
          //       textAlign: TextAlign.center,
          //       style: TextStyle(color: Colors.blue[900], fontSize: 16.0),
          //     )
          //   ],
          // )
          child: Image.asset(
            'assets/images/loading.gif',
            fit: BoxFit.fill,
          ),
        ));
  }
}
