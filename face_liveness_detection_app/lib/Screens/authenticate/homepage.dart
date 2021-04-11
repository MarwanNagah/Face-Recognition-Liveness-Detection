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
            color: Colors.blue[800],
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.60,
                child: Center(
                  child: Image.asset(
                    'assets/images/car_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  color: Color(0xFFF3F3F5),
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
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Login',
                          style: TextStyle(
                              color: Color(0xFF0F2E48),
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    GestureDetector(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width,
                      
                          child:
                              Image.asset('assets/images/user_password.png')),
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
