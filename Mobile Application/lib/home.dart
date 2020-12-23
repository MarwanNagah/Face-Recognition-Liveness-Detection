import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 80),
                alignment: Alignment.bottomCenter,
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 45.0,
                  child: RaisedButton(
                    color: Colors.greenAccent[400],
                    onPressed: () {},
                    child: Text("Start"),
                  ),
                )),
            Image(
              image: AssetImage("assets/12.gif"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.scaleDown,
            ),
//        [Your content

            Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 170.0),
                child: RichText(
                  text: TextSpan(
                    text: "Face",
                    style: TextStyle(color: Colors.white, fontSize: 60),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' App',
                          style: TextStyle(color: Colors.greenAccent[400])),
                    ],
                  ),
                )),
          ],
        ));
  }
}
