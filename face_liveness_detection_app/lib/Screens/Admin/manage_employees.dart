import 'package:face_liveness_detection_app/Models/institution.dart';
import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:face_liveness_detection_app/Providers/auth.dart';
import 'package:face_liveness_detection_app/Providers/institutionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageEmployees extends StatefulWidget {
  static const routeName = '/manageemployees';
  @override
  _ManageEmployeesState createState() => _ManageEmployeesState();
}

class _ManageEmployeesState extends State<ManageEmployees> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  var isloading = false;
  var isInit = true;
  bool isNoVisiblePassword = true;
  String password = '';

  RegExp regname = new RegExp(r"^[a-zA-Z]{2,20}$");
  RegExp regmail =
      new RegExp(r"^[a-zA-Z0-9_\-\.]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,3}");

  var editEmployee = User(
    uid: null,
    fUser: null,
    firstName: '',
    lastName: '',
    eMail: '',
  );
  var intialValues = {
    'firstName': '',
    'lastName': '',
    'eMail': true,
  };

  @override
  void didChangeDependencies() {
    if (isInit) {
      final userId = ModalRoute.of(context).settings.arguments as String;
      // if (userId != null) {
      //   editEmployee = Provider.of<InstitutionProvider>(context, listen: false)
      //       .findEmployeeById(userId);

      //   intialValues = {
      //     'firstName': editEmployee.firstName,
      //     'lastName': editEmployee.lastName,
      //     'eMail': editEmployee.eMail
      //   };
      // }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  Future<void> formSetup() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isloading = true;
    });
    // if (editInstitution.id != null) {
    //   await Provider.of<InstitutionProvider>(context, listen: false)
    //       .updateInstitution(editInstitution.id, editInstitution);
    // } else {
    //   try {
    //     await Provider.of<InstitutionProvider>(context, listen: false)
    //         .addInstitution(editInstitution);
    try {
      await Provider.of<InstitutionProvider>(context, listen: false)
          .fetchInstitution();
      Institution adInstitution =
          Provider.of<InstitutionProvider>(context, listen: false).institution;
      User empresult = await _auth.registerWithEmailAndPassword(
        email: editEmployee.eMail,
        password: password,
        userType: 0,
        firstName: editEmployee.firstName,
        lastName: editEmployee.lastName,
      );

      await Provider.of<InstitutionProvider>(context, listen: false)
          .addEmployeeToInstitution(adInstitution.id, empresult);
      print("admin id instit : ${adInstitution.id}");
      print("employee id  : ${empresult.uid}");
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
      print(error);
    }

    setState(() {
      isloading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 50.0),
                          child: RichText(
                            text: TextSpan(
                              text: "Add ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 40),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Employee',
                                    style: TextStyle(
                                        color: Colors.greenAccent[400])),
                              ],
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                        child: TextFormField(
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              labelText: 'First Name',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your First Name';
                              } else if (!regname.hasMatch(value)) {
                                return 'Your first name must be 2-20 characters long, contain only letters';
                              } else
                                return null;
                            },
                            onSaved: (value) {
                              editEmployee = User(
                                  uid: editEmployee.uid,
                                  fUser: null,
                                  firstName: value,
                                  lastName: editEmployee.lastName,
                                  eMail: editEmployee.eMail);
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: TextFormField(
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              labelText: 'Last Name',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Last Name';
                              } else if (!regname.hasMatch(value)) {
                                return 'Your last name must be 2-20 characters long, contain only letters';
                              } else
                                return null;
                            },
                            onSaved: (value) {
                              editEmployee = User(
                                  uid: editEmployee.uid,
                                  fUser: null,
                                  firstName: editEmployee.firstName,
                                  lastName: value,
                                  eMail: editEmployee.eMail);
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              labelText: 'E-mail',
                              prefixIcon: const Icon(
                                Icons.mail,
                                color: Colors.green,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your E-mail';
                              } else if (!regmail.hasMatch(value)) {
                                return 'E-mail is invalid';
                              } else
                                return null;
                            },
                            onSaved: (value) {
                              editEmployee = User(
                                  uid: editEmployee.uid,
                                  fUser: null,
                                  firstName: editEmployee.firstName,
                                  lastName: editEmployee.lastName,
                                  eMail: value);
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: TextFormField(
                          obscureText: this.isNoVisiblePassword,
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
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.green,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your Password';
                            } else if (value.length < 6) {
                              return 'Enter a password longer than 6 characters';
                            } else
                              return null;
                          },
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: TextFormField(
                          obscureText: this.isNoVisiblePassword,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                            labelText: 'Confirm Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.green,
                            ),
                          ),
                          validator: (val) => val != password
                              ? 'Password does not match'
                              : null,
                        ),
                      ),
                      // Container(
                      //   height: 90,
                      //   padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
                      //   child: OutlineButton(
                      //       onPressed: () => null,
                      //       child: Stack(
                      //         alignment: Alignment.centerLeft,
                      //         children: <Widget>[
                      //           Icon(Icons.camera_alt),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: <Widget>[
                      //               Text('Upload image'),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       highlightedBorderColor: Colors.green,
                      //       color: Colors.green,
                      //       borderSide: new BorderSide(color: Colors.green),
                      //       shape: new RoundedRectangleBorder(
                      //           borderRadius: new BorderRadius.circular(8.0))),
                      // ),
                      GestureDetector(
                          onTap: formSetup,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      color: Color(0xff30384c),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                            child: Text(
                                          'ADD',
                                          style: TextStyle(
                                              color: Colors.greenAccent[400],
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                            // child: check
                                            //     ? Text(
                                            //         'EDIT',
                                            //         style: TextStyle(
                                            //             color: Colors
                                            //                 .greenAccent[400],
                                            //             fontSize: 15,
                                            //             fontWeight:
                                            //                 FontWeight.bold),
                                            //       )
                                            //     : Text(
                                            //         'ADD',
                                            //         style: TextStyle(
                                            //             color: Colors
                                            //                 .greenAccent[400],
                                            //             fontSize: 15,
                                            //             fontWeight:
                                            //                 FontWeight.bold),
                                            //       )
                                            ),
                                      )))))
                    ],
                  ))),
    );
  }
}
