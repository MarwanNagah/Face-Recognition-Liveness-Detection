import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  final Function toggleView;
  Homepage({this.toggleView});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.60,
                width: MediaQuery.of(context).size.width * 0.60,
                child: Center(
                  child: Image.asset(
                    'assets/images/12.gif',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 90.0),
              child: RichText(
                text: TextSpan(
                  text: "Face",
                  style: TextStyle(color: Colors.white, fontSize: 52),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' App',
                        style: TextStyle(color: Colors.greenAccent[400])),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(50.0),
                    topRight: const Radius.circular(50.0),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 90),
                      child: Text('Welcome',
                          style: TextStyle(
                              color: Colors.greenAccent[400],
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                    ),
                    GestureDetector(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 3,
                          child: Image.asset('assets/images/15.gif')),
                      onTap: () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(
                        //   builder: (_buildContext) => SignIn(),
                        // ));
                        toggleView();
                      },
                    ),
                  ]),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 10),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: []),
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (_buildContext) => Register(),
                      // ));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
