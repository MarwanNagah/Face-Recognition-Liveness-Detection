import 'package:face_liveness_detection_app/Models/institution.dart';
import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:face_liveness_detection_app/Providers/institutionProvider.dart';
import 'package:face_liveness_detection_app/Screens/Widgets/employees_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manage_employees.dart';

class EmployeesSc extends StatefulWidget {
  static const routeName = '/EmployeeSc';
  static bool isloading = false;

  @override
  _EmployeesScState createState() => _EmployeesScState();
}

class _EmployeesScState extends State<EmployeesSc> {
  //User employee;
  bool isTest = false;
  Future<void> getemployees(BuildContext context) async {
    await Provider.of<InstitutionProvider>(context, listen: false)
        .fetchEmployeesNo('test');
    await Provider.of<InstitutionProvider>(context, listen: false).fetchusers();

    isTest = EmployeesSc.isloading;
    print(isTest);
  }

  void testChange() {
    setState(() {
      isTest = !isTest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Object>(
            future: getemployees(context),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.greenAccent[400])),
                    )
                  : isTest
                      ? RefreshIndicator(
                          onRefresh: () => getemployees(context)
                              .then((value) => setState(() {})),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Consumer<InstitutionProvider>(
                                builder: (context, employeesdata, child) =>
                                    ListView.builder(
                                        itemCount: employeesdata
                                            .institutionemp.employees.length,
                                        itemBuilder: (_, i) => Column(
                                              children: [
                                                InstitutionEmployees(
                                                  id: employeesdata
                                                      .institutionemp
                                                      .employees[i]
                                                      .uid,
                                                  firstname: employeesdata
                                                      .institutionemp
                                                      .employees[i]
                                                      .firstName,
                                                  lastname: employeesdata
                                                      .institutionemp
                                                      .employees[i]
                                                      .lastName,
                                                  email: employeesdata
                                                      .institutionemp
                                                      .employees[i]
                                                      .eMail,
                                                )
                                              ],
                                            ))),
                          ),
                        )
                      : Center(
                          // esht8l mn awl hena ya ABDO
                          child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.black54,
                                offset: Offset(2, 6),
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xff30384c),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.greenAccent[400],
                                size: 30.0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManageEmployees()),
                                ).then((value) => setState(() {}));
                              },
                            ),
                          ),
                        ));
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManageEmployees()),
            ).then((value) => setState(() {}));
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.greenAccent[400],
        ));
  }
}
