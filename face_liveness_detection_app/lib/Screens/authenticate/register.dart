import 'package:flutter/material.dart';
import 'package:face_liveness_detection_app/Providers/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:face_liveness_detection_app/Screens/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

enum UserTypes { Personal, Business }

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  bool isNoVisiblePassword = true;

  String email = '';
  String password = '';
  String fName = '';
  String lName = '';
  UserTypes userType = UserTypes.Personal;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.blue[800],
                centerTitle: true,
                elevation: 0,
                title: Text(
                  'Sign Up',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
            body: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue[800],
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 3),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text('Scan Car \nQR',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                        color: Color(0xFFF3F3F5),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(50.0),
                          topRight: const Radius.circular(50.0),
                        )),
                    child: buildBody(),
                  ),
                ),
              ],
            ),
            // body: Container(
            //   padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            //   child: Form(
            //     key: _formKey,
            //     child: Column(
            //       children: <Widget>[
            //         SizedBox(height: 20.0),
            //         TextFormField(
            //           decoration: InputDecoration(
            //               hintText: 'First Name',
            //               enabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(
            //                       color: Colors.black12, width: 2.0)),
            //               focusedBorder: OutlineInputBorder(
            //                   borderSide:
            //                       BorderSide(color: Colors.blue, width: 2.0))),
            //           validator: (val) =>
            //               val.isEmpty ? 'Enter your first name' : null,
            //           onChanged: (val) {
            //             setState(() => fName = val);
            //           },
            //         ),
            //         SizedBox(height: 20.0),
            //         TextFormField(
            //           decoration: InputDecoration(
            //               hintText: 'Last Name',
            //               enabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(
            //                       color: Colors.black12, width: 2.0)),
            //               focusedBorder: OutlineInputBorder(
            //                   borderSide:
            //                       BorderSide(color: Colors.blue, width: 2.0))),
            //           validator: (val) =>
            //               val.isEmpty ? 'Enter your last name' : null,
            //           onChanged: (val) {
            //             setState(() => lName = val);
            //           },
            //         ),
            //         SizedBox(height: 20.0),
            //         TextFormField(
            //           decoration: InputDecoration(
            //               hintText: 'Email',
            //               enabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(
            //                       color: Colors.black12, width: 2.0)),
            //               focusedBorder: OutlineInputBorder(
            //                   borderSide:
            //                       BorderSide(color: Colors.blue, width: 2.0))),
            //           validator: (val) => val.isEmpty ? 'Enter an email' : null,
            //           onChanged: (val) {
            //             setState(() => email = val);
            //           },
            //         ),
            //         SizedBox(height: 20.0),
            //         TextFormField(
            //           obscureText: true,
            //           decoration: InputDecoration(
            //               hintText: 'Password',
            //               enabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(
            //                       color: Colors.black12, width: 2.0)),
            //               focusedBorder: OutlineInputBorder(
            //                   borderSide:
            //                       BorderSide(color: Colors.blue, width: 2.0))),
            //           validator: (val) => val.length < 6
            //               ? 'Enter a password longer than 6 characters'
            //               : null,
            //           onChanged: (val) {
            //             setState(() => password = val);
            //           },
            //         ),
            //         SizedBox(height: 20.0),
            //         Column(
            //           children: <Widget>[
            //             ListTile(
            //               title: const Text('Personal'),
            //               leading: Radio(
            //                 value: UserTypes.Personal,
            //                 groupValue: userType,
            //                 onChanged: (UserTypes value) {
            //                   setState(() {
            //                     userType = value;
            //                   });
            //                 },
            //               ),
            //             ),
            //             ListTile(
            //               title: const Text('Business'),
            //               leading: Radio(
            //                 value: UserTypes.Business,
            //                 groupValue: userType,
            //                 onChanged: (UserTypes value) {
            //                   setState(() {
            //                     userType = value;
            //                   });
            //                 },
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 20.0),
            //         RaisedButton(
            //           padding: EdgeInsets.all(15),
            //           shape: new RoundedRectangleBorder(
            //             borderRadius: new BorderRadius.circular(10.0),
            //           ),
            //           textColor: Colors.white,
            //           color: Colors.blue,
            //           child: Text(
            //             'Register',
            //             style: GoogleFonts.lato(
            //               textStyle: TextStyle(color: Colors.white),
            //               fontSize: 15,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //           onPressed: () async {
            //             if (_formKey.currentState.validate()) {
            //               setState(() => loading = true);
            //               String newUserType = '1';
            //               if (userType == UserTypes.Business) {
            //                 newUserType = '2';
            //               }
            //               dynamic result =
            //                   await _auth.registerWithEmailAndPassword(
            //                 email: email,
            //                 password: password,
            //                 userType: newUserType,
            //                 firstName: fName,
            //                 lastName: lName,
            //               );
            //               if (result == null) {
            //                 setState(() {
            //                   error = 'Please enter a valid email';
            //                   loading = false;
            //                 });
            //               }
            //             }
            //           },
            //         ),
            //         SizedBox(height: 12.0),
            //         Text(
            //           error,
            //           style: TextStyle(color: Colors.red, fontSize: 14.0),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          );
  }

  Widget buildBody() {
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 5, left: 20, right: 20, top: 20),
                        child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                color: Color(0xFF0F2E48), fontSize: 14),
                            autofocus: false,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                filled: true,
                                fillColor: Color(0xFFF3F3F5),
                                focusColor: Color(0xFFF3F3F5),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.blue[800])),
                                hintText: 'E-mail')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter your first name' : null,
                            onChanged: (val) {
                              setState(() => fName = val);
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: Color(0xFF0F2E48), fontSize: 14),
                            autofocus: false,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                filled: true,
                                fillColor: Color(0xFFF3F3F5),
                                focusColor: Color(0xFFF3F3F5),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.blue[800])),
                                hintText: 'First Name')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter your last name' : null,
                            onChanged: (val) {
                              setState(() => lName = val);
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: Color(0xFF0F2E48), fontSize: 14),
                            autofocus: false,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                filled: true,
                                fillColor: Color(0xFFF3F3F5),
                                focusColor: Color(0xFFF3F3F5),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.blue[800])),
                                hintText: 'Last Name')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: TextFormField(
                            validator: (val) => val.length < 6
                                ? 'Enter a password longer than 6 characters'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            obscureText: this.isNoVisiblePassword,
                            style: TextStyle(
                                color: Color(0xFF0F2E48), fontSize: 14),
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (this.isNoVisiblePassword)
                                          this.isNoVisiblePassword = false;
                                        else
                                          this.isNoVisiblePassword = true;
                                      });
                                    },
                                    child: (this.isNoVisiblePassword)
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/images/icon_eye_close.png",
                                              width: 15,
                                              height: 15,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/images/icon_eye_open.png",
                                              width: 15,
                                              height: 15,
                                            ),
                                          )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                filled: true,
                                fillColor: Color(0xFFF3F3F5),
                                focusColor: Color(0xFFF3F3F5),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.blue[800])),
                                hintText: 'Password')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: TextFormField(
                            validator: (val) => val != password
                                ? 'Password does not match'
                                : null,
                            // onChanged: (val) {
                            //   setState(() => password = val);
                            // },
                            obscureText: this.isNoVisiblePassword,
                            style: TextStyle(
                                color: Color(0xFF0F2E48), fontSize: 14),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                filled: true,
                                fillColor: Color(0xFFF3F3F5),
                                focusColor: Color(0xFFF3F3F5),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAAB5C3))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.blue[800])),
                                hintText: "Confirm Password")),
                      ),
                      SizedBox(height: 8.0),
                      error == ''
                          ? SizedBox(height: 0.0)
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                error,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                            ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Personal'),
                            leading: Radio(
                              value: UserTypes.Personal,
                              groupValue: userType,
                              onChanged: (UserTypes value) {
                                setState(() {
                                  userType = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Business'),
                            leading: Radio(
                              value: UserTypes.Business,
                              groupValue: userType,
                              onChanged: (UserTypes value) {
                                setState(() {
                                  userType = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    String newUserType = '1';
                    if (userType == UserTypes.Business) {
                      newUserType = '2';
                    }
                    dynamic result = await _auth.registerWithEmailAndPassword(
                      email: email,
                      password: password,
                      userType: newUserType,
                      firstName: fName,
                      lastName: lName,
                    );
                    if (result == null) {
                      setState(() {
                        error = 'Please enter a valid email';
                        loading = false;
                      });
                    }
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            color: Colors.blue[800],
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                  child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                            )))),
              ),
            ]));
  }
}
