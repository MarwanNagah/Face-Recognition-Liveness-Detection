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
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.greenAccent[400],
                  textColor: Colors.white,
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                  padding: EdgeInsets.all(30),
                  shape: CircleBorder(),
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
