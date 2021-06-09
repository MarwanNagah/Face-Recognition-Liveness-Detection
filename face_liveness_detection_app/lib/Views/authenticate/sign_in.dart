import 'package:face_liveness_detection_app/Views/loading.dart';
import 'package:flutter/material.dart';
import 'package:face_liveness_detection_app/Controllers/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController _textEditingControllerPassword =
      TextEditingController();
  TextEditingController _textEditingControllerUser = TextEditingController();

  bool isNoVisiblePassword = true;

  final focus = FocusNode();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.black,
                centerTitle: true,
                elevation: 0,
                title: Text(
                  'LogIn',
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
                    color: Colors.black,
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
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Face",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 55),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: ' App',
                                            style: TextStyle(
                                                color:
                                                    Colors.greenAccent[400])),
                                      ],
                                    ),
                                  )),
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
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              height: 0,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: TextFormField(
                                          controller:
                                              this._textEditingControllerUser,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(
                                              color: Color(0xFF0F2E48),
                                              fontSize: 14),
                                          autofocus: false,
                                          validator: (val) => val.isEmpty
                                              ? 'Enter a valid email'
                                              : null,
                                          onChanged: (val) {
                                            setState(() => email = val);
                                          },
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(focus);
                                          },
                                          decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  "assets/images/icon_user.png",
                                                  width: 15,
                                                  height: 15,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xFFAAB5C3))),
                                              filled: true,
                                              fillColor: Color(0xFFF3F3F5),
                                              focusColor: Color(0xFFF3F3F5),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xFFAAB5C3))),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color: Colors.blue[800])),
                                              hintText: 'E-mail')),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25, horizontal: 20),
                                      child: TextFormField(
                                          focusNode: focus,
                                          controller: this
                                              ._textEditingControllerPassword,
                                          obscureText: this.isNoVisiblePassword,
                                          style: TextStyle(
                                              color: Color(0xFF0F2E48),
                                              fontSize: 14),
                                          validator: (val) => val.length < 6
                                              ? 'Enter a valid password'
                                              : null,
                                          onChanged: (val) {
                                            setState(() => password = val);
                                          },
                                          decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  "assets/images/icon_password.png",
                                                  width: 15,
                                                  height: 15,
                                                ),
                                              ),
                                              suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (this
                                                          .isNoVisiblePassword)
                                                        this.isNoVisiblePassword =
                                                            false;
                                                      else
                                                        this.isNoVisiblePassword =
                                                            true;
                                                    });
                                                  },
                                                  child: (this
                                                          .isNoVisiblePassword)
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Image.asset(
                                                            "assets/images/icon_eye_close.png",
                                                            width: 15,
                                                            height: 15,
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Image.asset(
                                                            "assets/images/icon_eye_open.png",
                                                            width: 15,
                                                            height: 15,
                                                          ),
                                                        )),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xFFAAB5C3))),
                                              filled: true,
                                              fillColor: Color(0xFFF3F3F5),
                                              focusColor: Color(0xFFF3F3F5),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xFFAAB5C3))),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color: Colors.blue[800])),
                                              hintText: 'Password')),
                                    ),
                                    SizedBox(height: 12.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        error,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 14.0),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() => loading = true);
                                          dynamic result = await _auth
                                              .signInWithEmailAndPassword(
                                                  email, password);
                                          if (result == null) {
                                            setState(() {
                                              error =
                                                  'Couldn\'t sign in please check email and password then try again';
                                              loading = false;
                                            });
                                          }
                                        }
                                      },
                                      child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              color: Colors.greenAccent[400],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Center(
                                                    child: Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ))),
                                    ),
                                    SizedBox(),
                                    GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25, horizontal: 10),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    'You dot not have an account?' +
                                                        ' \n',
                                                style: TextStyle(
                                                    color: Color(0xFF0F2E48),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15)),
                                            TextSpan(
                                                text: 'Sign Up',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Color(0xFF0F2E48),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ]),
                                        ),
                                      ),
                                      onTap: () {
                                        widget.toggleView();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          );
  }

  // Widget buildBody() {
  //   return Form(
  //       key: _formKey,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.max,
  //         children: <Widget>[
  //           SizedBox(
  //             height: 0,
  //           ),
  //           Expanded(
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisSize: MainAxisSize.max,
  //                 children: <Widget>[
  //                   SizedBox(
  //                     height: 30,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                         horizontal: 20, vertical: 15),
  //                     child: TextFormField(
  //                         controller: this._textEditingControllerUser,
  //                         keyboardType: TextInputType.emailAddress,
  //                         style:
  //                             TextStyle(color: Color(0xFF0F2E48), fontSize: 14),
  //                         autofocus: false,
  //                         validator: (val) =>
  //                             val.isEmpty ? 'Enter a valid email' : null,
  //                         onChanged: (val) {
  //                           setState(() => email = val);
  //                         },
  //                         onFieldSubmitted: (v) {
  //                           FocusScope.of(context).requestFocus(focus);
  //                         },
  //                         decoration: InputDecoration(
  //                             prefixIcon: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: Image.asset(
  //                                 "assets/images/icon_user.png",
  //                                 width: 15,
  //                                 height: 15,
  //                               ),
  //                             ),
  //                             enabledBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(25),
  //                                 borderSide:
  //                                     BorderSide(color: Color(0xFFAAB5C3))),
  //                             filled: true,
  //                             fillColor: Color(0xFFF3F3F5),
  //                             focusColor: Color(0xFFF3F3F5),
  //                             focusedBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(25),
  //                                 borderSide:
  //                                     BorderSide(color: Color(0xFFAAB5C3))),
  //                             border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(25),
  //                                 borderSide:
  //                                     BorderSide(color: Colors.blue[800])),
  //                             hintText: 'E-mail')),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                         vertical: 25, horizontal: 20),
  //                     child: TextFormField(
  //                         focusNode: focus,
  //                         controller: this._textEditingControllerPassword,
  //                         obscureText: this.isNoVisiblePassword,
  //                         style:
  //                             TextStyle(color: Color(0xFF0F2E48), fontSize: 14),
  //                         validator: (val) =>
  //                             val.length < 6 ? 'Enter a valid password' : null,
  //                         onChanged: (val) {
  //                           setState(() => password = val);
  //                         },
  //                         decoration: InputDecoration(
  //                             prefixIcon: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: Image.asset(
  //                                 "assets/images/icon_password.png",
  //                                 width: 15,
  //                                 height: 15,
  //                               ),
  //                             ),
  //                             suffixIcon: GestureDetector(
  //                                 onTap: () {
  //                                   setState(() {
  //                                     if (this.isNoVisiblePassword)
  //                                       this.isNoVisiblePassword = false;
  //                                     else
  //                                       this.isNoVisiblePassword = true;
  //                                   });
  //                                 },
  //                                 child: (this.isNoVisiblePassword)
  //                                     ? Padding(
  //                                         padding: const EdgeInsets.all(8.0),
  //                                         child: Image.asset(
  //                                           "assets/images/icon_eye_close.png",
  //                                           width: 15,
  //                                           height: 15,
  //                                         ),
  //                                       )
  //                                     : Padding(
  //                                         padding: const EdgeInsets.all(8.0),
  //                                         child: Image.asset(
  //                                           "assets/images/icon_eye_open.png",
  //                                           width: 15,
  //                                           height: 15,
  //                                         ),
  //                                       )),
  //                             enabledBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(25),
  //                                 borderSide:
  //                                     BorderSide(color: Color(0xFFAAB5C3))),
  //                             filled: true,
  //                             fillColor: Color(0xFFF3F3F5),
  //                             focusColor: Color(0xFFF3F3F5),
  //                             focusedBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(25),
  //                                 borderSide:
  //                                     BorderSide(color: Color(0xFFAAB5C3))),
  //                             border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(25),
  //                                 borderSide:
  //                                     BorderSide(color: Colors.blue[800])),
  //                             hintText: 'Password')),
  //                   ),
  //                   SizedBox(height: 12.0),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 10),
  //                     child: Text(
  //                       error,
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(color: Colors.red, fontSize: 14.0),
  //                     ),
  //                   ),
  //                   GestureDetector(
  //                     onTap: () async {
  //                       if (_formKey.currentState.validate()) {
  //                         setState(() => loading = true);
  //                         dynamic result = await _auth
  //                             .signInWithEmailAndPassword(email, password);
  //                         if (result == null) {
  //                           setState(() {
  //                             error =
  //                                 'Couldn\'t sign in please check email and password then try again';
  //                             loading = false;
  //                           });
  //                         }
  //                       }
  //                     },
  //                     child: SizedBox(
  //                         height: MediaQuery.of(context).size.height * 0.07,
  //                         width: MediaQuery.of(context).size.width * 0.7,
  //                         child: Card(
  //                             elevation: 10,
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(40),
  //                             ),
  //                             color: Colors.blue[800],
  //                             child: Padding(
  //                               padding:
  //                                   const EdgeInsets.symmetric(horizontal: 10),
  //                               child: Center(
  //                                   child: Text(
  //                                 'Login',
  //                                 style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 15,
  //                                     fontWeight: FontWeight.bold),
  //                               )),
  //                             ))),
  //                   ),
  //                   SizedBox(),
  //                   GestureDetector(
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 25, horizontal: 10),
  //                       child: RichText(
  //                         textAlign: TextAlign.center,
  //                         text: TextSpan(children: [
  //                           TextSpan(
  //                               text: 'You dot not have an account?' + ' \n',
  //                               style: TextStyle(
  //                                   color: Color(0xFF0F2E48),
  //                                   fontWeight: FontWeight.normal,
  //                                   fontSize: 15)),
  //                           TextSpan(
  //                               text: 'Sign Up',
  //                               style: TextStyle(
  //                                   decoration: TextDecoration.underline,
  //                                   color: Color(0xFF0F2E48),
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 16)),
  //                         ]),
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       Navigator.of(context).push(MaterialPageRoute(
  //                         builder: (_buildContext) => Register(),
  //                       ));
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ));
  // }
}
