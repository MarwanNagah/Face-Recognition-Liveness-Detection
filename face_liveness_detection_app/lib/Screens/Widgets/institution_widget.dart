import 'package:face_liveness_detection_app/Providers/institutionProvider.dart';
import 'package:face_liveness_detection_app/Screens/Admin/ad_institution.dart';
import 'package:face_liveness_detection_app/Screens/Admin/manage_institution.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagerInstitution extends StatefulWidget {
  final String id;
  final String institutionName;
  final String appusage;
  final bool isActive;
  final int employeesNumber;
  Function isTest;

  ManagerInstitution(
      {this.id,
      this.institutionName,
      this.appusage,
      this.isActive,
      this.employeesNumber,
      this.isTest}) {
    print("institution widget");
  }

  @override
  _ManagerInstitutionState createState() => _ManagerInstitutionState(
      this.id,
      this.institutionName,
      this.appusage,
      this.isActive,
      this.employeesNumber,
      this.isTest);
}

class _ManagerInstitutionState extends State<ManagerInstitution> {
  final String id;
  final String institutionName;
  final String appusage;
  final bool isActive;
  final int employeesNumber;
  Function isTest;

  _ManagerInstitutionState(this.id, this.institutionName, this.appusage,
      this.isActive, this.employeesNumber, this.isTest);

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1)}";
  }

  Future<void> createDialog(BuildContext context) async {
    final scaffold = Scaffold.of(context);
    final prov = Provider.of<InstitutionProvider>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure you want to delete this institution ?"),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text("Submit"),
                onPressed: () async {
                  try {
                    prov.deleteInstitution(id);
                    isTest();
                    Navigator.of(context).pop();
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Deleting failed!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    print(error);
                  }
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 140.0,
                              height: 140.0,
                              child: CircleAvatar(
                                backgroundColor: Color(0xff30384c),
                                child: Text(
                                  "${institutionName[0]}".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 60.0,
                                      color: Colors.greenAccent[400]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Institution Information',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.0),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    child: new CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 16.0,
                                      child: new Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ManageInstitution(),
                                            settings: RouteSettings(
                                              arguments: id,
                                            )),
                                      ).then((value) => setState(() {}));
                                    },
                                  )
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    child: new CircleAvatar(
                                      backgroundColor: Colors.red[600],
                                      radius: 16.0,
                                      child: new Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                    onTap: () {
                                      createDialog(context);
                                    },
                                  )
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Institution Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 8.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(capitalize(institutionName)),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 40.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'App Usage',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 8.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  capitalize(appusage),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 40.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Employees Number',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 8.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Text(
                                  "${employeesNumber.toString()}",
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 40.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Active',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 8.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              isActive == true
                                  ? new Flexible(
                                      child: new Text(
                                        'Yes',
                                      ),
                                    )
                                  : new Flexible(
                                      child: new Text(
                                      'No',
                                    ))
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// class ManagerInstitution extends StatelessWidget {
//   final String id;
//   final String institutionName;
//   final String appusage;
//   final int employeesNumber;
//   final bool isActive;

//   ManagerInstitution(this.id, this.institutionName, this.appusage,
//       this.employeesNumber, this.isActive);

//   String capitalize(String s) {
//     return "${s[0].toUpperCase()}${s.substring(1)}";
//   }

//   Future<void> createDialog(BuildContext context) async {
//     final scaffold = Scaffold.of(context);
//     final prov = Provider.of<InstitutionProvider>(context, listen: false);
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Are you sure you want to delete this institution ?"),
//             actions: <Widget>[
//               MaterialButton(
//                 elevation: 5.0,
//                 child: Text("Cancel"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               MaterialButton(
//                 elevation: 5.0,
//                 child: Text("Submit"),
//                 onPressed: () async {
//                   try {
//                     prov.deleteInstitution(id);
//                     Navigator.of(context).pop();
//                   } catch (error) {
//                     scaffold.showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           'Deleting failed!',
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     );
//                     print(error);
//                   }
//                 },
//               )
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: new ListView(
//         children: <Widget>[
//           Column(
//             children: <Widget>[
//               new Container(
//                 height: 250.0,
//                 color: Colors.white,
//                 child: new Column(
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(top: 20.0),
//                       child: new Stack(fit: StackFit.loose, children: <Widget>[
//                         new Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             new Container(
//                               width: 140.0,
//                               height: 140.0,
//                               child: CircleAvatar(
//                                 backgroundColor: Color(0xff30384c),
//                                 child: Text(
//                                   "${institutionName[0]}".toUpperCase(),
//                                   style: TextStyle(
//                                       fontSize: 60.0,
//                                       color: Colors.greenAccent[400]),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ]),
//                     )
//                   ],
//                 ),
//               ),
//               new Container(
//                 color: Color(0xffFFFFFF),
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 25.0),
//                   child: new Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                           padding: EdgeInsets.only(
//                               left: 25.0, right: 25.0, top: 25.0),
//                           child: new Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               new Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   new Text(
//                                     'Institution Information',
//                                     style: TextStyle(
//                                         fontSize: 18.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(width: 20.0),
//                               new Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     child: new CircleAvatar(
//                                       backgroundColor: Colors.blue,
//                                       radius: 16.0,
//                                       child: new Icon(
//                                         Icons.edit,
//                                         color: Colors.white,
//                                         size: 20.0,
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ManageInstitution(),
//                                             settings: RouteSettings(
//                                               arguments: id,
//                                             )),
//                                       );
//                                     },
//                                   )
//                                 ],
//                               ),
//                               new Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     child: new CircleAvatar(
//                                       backgroundColor: Colors.red[600],
//                                       radius: 16.0,
//                                       child: new Icon(
//                                         Icons.delete,
//                                         color: Colors.white,
//                                         size: 20.0,
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       createDialog(context);
//                                     },
//                                   )
//                                 ],
//                               )
//                             ],
//                           )),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               left: 25.0, right: 25.0, top: 25.0),
//                           child: new Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               new Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   new Text(
//                                     'Institution Name',
//                                     style: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               left: 25.0, right: 25.0, top: 8.0),
//                           child: new Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               new Flexible(
//                                 child: new Text(capitalize(institutionName)),
//                               ),
//                             ],
//                           )),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               left: 25.0, right: 25.0, top: 40.0),
//                           child: new Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               new Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   new Text(
//                                     'App Usage',
//                                     style: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               left: 25.0, right: 25.0, top: 8.0),
//                           child: new Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               new Flexible(
//                                 child: new Text(
//                                   capitalize(appusage),
//                                 ),
//                               ),
//                             ],
//                           )),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               left: 25.0, right: 25.0, top: 40.0),
//                           child: new Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               new Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   new Text(
//                                     'Employees Number',
//                                     style: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               left: 25.0, right: 25.0, top: 8.0),
//                           child: new Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               new Flexible(
//                                 child: new Text(
//                                   "${employeesNumber.toString()}",
//                                 ),
//                               ),
//                             ],
//                           )),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               left: 25.0, right: 25.0, top: 40.0),
//                           child: new Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               new Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   new Text(
//                                     'Active',
//                                     style: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               left: 25.0, right: 25.0, top: 8.0),
//                           child: new Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: <Widget>[
//                               isActive == true
//                                   ? new Flexible(
//                                       child: new Text(
//                                         'Yes',
//                                       ),
//                                     )
//                                   : new Flexible(
//                                       child: new Text(
//                                       'No',
//                                     ))
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
