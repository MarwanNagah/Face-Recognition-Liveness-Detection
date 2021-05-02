import 'package:face_liveness_detection_app/Models/institution.dart';
import 'package:face_liveness_detection_app/Providers/institutionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageInstitution extends StatefulWidget {
  static const routeName = '/manageinstitution';
  @override
  _ManageInstitutionState createState() => _ManageInstitutionState();
}

enum institutuionTypes { Yes, No }

class _ManageInstitutionState extends State<ManageInstitution> {
  final _formKey = GlobalKey<FormState>();
  var nameFocusNode = FocusNode();
  var appFocusNode = FocusNode();
  var isloading = false;
  var isInit = true;
  institutuionTypes insType = institutuionTypes.Yes;
  var editInstitution = Institution(
    id: null,
    institutionName: '',
    appusage: '',
    //employeesNumber: 0,
    isActive: true,
  );
  var intialValues = {
    'institutionName': '',
    'appusage': '',
    //'employeesNumber': 0,
    'isActive': true,
  };

  @override
  void didChangeDependencies() {
    if (isInit) {
      final institutionId = ModalRoute.of(context).settings.arguments as String;
      if (institutionId != null) {
        editInstitution =
            Provider.of<InstitutionProvider>(context, listen: false)
                .findById(institutionId);
        intialValues = {
          'institutionName': editInstitution.institutionName,
          'appusage': editInstitution.appusage,
          'employeesNumber': editInstitution.employeesNumber,
          'isActive': editInstitution.isActive
        };
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    appFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    appFocusNode.dispose();
    super.dispose();
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
    if (editInstitution.id != null) {
      await Provider.of<InstitutionProvider>(context, listen: false)
          .updateInstitution(editInstitution.id, editInstitution);
    } else {
      try {
        await Provider.of<InstitutionProvider>(context, listen: false)
            .addInstitution(editInstitution);
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
    }
    setState(() {
      isloading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var check = false;
    if (editInstitution.id != null) {
      check = true;
    }
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    check
                        ? Text(
                            'Edit your showroom',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                                fontSize: 30),
                          )
                        : RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Create ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 40),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Institution',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.greenAccent[400])),
                              ],
                            ),
                          ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                    ),
                    new Text(
                      'Institution Name :',
                      style: TextStyle(
                          color: Color(0xff30384c),
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    TextFormField(
                      initialValue: intialValues['institutionName'],
                      focusNode: nameFocusNode,
                      onTap: () {
                        setState(() {
                          FocusScope.of(context).requestFocus(nameFocusNode);
                        });
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.greenAccent[400],
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xff30384c),
                            ),
                          ),
                          labelText: 'Institution Name',
                          labelStyle: TextStyle(
                              color: nameFocusNode.hasFocus
                                  ? Colors.greenAccent[400]
                                  : Colors.black,
                              fontWeight: nameFocusNode.hasFocus
                                  ? FontWeight.w500
                                  : FontWeight.w300)),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(appFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Institution Name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editInstitution = Institution(
                            institutionName: value,
                            appusage: editInstitution.appusage,
                            isActive: editInstitution.isActive,
                            id: editInstitution.id);
                      },
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new Text(
                      'App Usage :',
                      style: TextStyle(
                          color: Color(0xff30384c),
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    TextFormField(
                      initialValue: intialValues['appusage'],
                      focusNode: appFocusNode,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.greenAccent[400],
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xff30384c),
                            ),
                          ),
                          labelText: 'AppUsage',
                          labelStyle: TextStyle(
                              color: appFocusNode.hasFocus
                                  ? Colors.greenAccent[400]
                                  : Colors.black,
                              fontWeight: appFocusNode.hasFocus
                                  ? FontWeight.w500
                                  : FontWeight.w300)),
                      textInputAction: TextInputAction.next,
                      //keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        // FocusScope.of(context).requestFocus(locationFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter App Usage';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editInstitution = Institution(
                            institutionName: editInstitution.institutionName,
                            appusage: value,
                            isActive: editInstitution.isActive,
                            id: editInstitution.id);
                      },
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new Text(
                      'Is Active :',
                      style: TextStyle(
                          color: Color(0xff30384c),
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Yes'),
                          leading: Radio(
                            activeColor: Colors.greenAccent[400],
                            value: institutuionTypes.Yes,
                            groupValue: insType,
                            onChanged: (institutuionTypes value) {
                              setState(() {
                                insType = value;
                              });
                              editInstitution = Institution(
                                  institutionName:
                                      editInstitution.institutionName,
                                  appusage: editInstitution.appusage,
                                  isActive: true,
                                  id: editInstitution.id);
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('No'),
                          leading: Radio(
                            activeColor: Colors.greenAccent[400],
                            value: institutuionTypes.No,
                            groupValue: insType,
                            onChanged: (institutuionTypes value) {
                              setState(() {
                                insType = value;
                              });
                              editInstitution = Institution(
                                  institutionName:
                                      editInstitution.institutionName,
                                  appusage: editInstitution.appusage,
                                  isActive: false,
                                  id: editInstitution.id);
                            },
                          ),
                        ),
                      ],
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    GestureDetector(
                        onTap: formSetup,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.5,
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
                                      )),
                                    ))))),
                  ],
                ),
              ),
            ),
    );
  }
}
