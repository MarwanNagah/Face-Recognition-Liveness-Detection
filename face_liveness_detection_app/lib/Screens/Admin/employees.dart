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
  bool isTest = false;
  User employee;
  Future<void> getemployees(BuildContext context) async {
    await Provider.of<InstitutionProvider>(context, listen: false)
        .fetchInstitution();
    Institution adInstitution =
        Provider.of<InstitutionProvider>(context, listen: false).institution;
    await Provider.of<InstitutionProvider>(context, listen: false)
        .fetchEmployeesNo(adInstitution.id);

    await Provider.of<InstitutionProvider>(context, listen: false).fetchusers();

    isTest = EmployeesSc.isloading;
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
                                          .institution.employees.length,
                                      itemBuilder: (_, i) => Column(
                                            children: [
                                              InstitutionEmployees(
                                                id: employeesdata.institution
                                                    .employees[i].uid,
                                                firstname: employeesdata
                                                    .institution
                                                    .employees[i]
                                                    .firstName,
                                                lastname: employeesdata
                                                    .institution
                                                    .employees[i]
                                                    .lastName,
                                                email: employeesdata.institution
                                                    .employees[i].eMail,
                                              )
                                            ],
                                          ))),
                          // child: Consumer<InstitutionProvider>(
                          //   builder: (context, institutiondata, child) =>
                          //       ManagerInstitution(
                          //     isTest: testChange,
                          //     id: institutiondata.institution.id,
                          //     institutionName:
                          //         institutiondata.institution.institutionName,
                          //     appusage: institutiondata.institution.appusage,
                          //     employeesNumber:
                          //         institutiondata.institution.getEmployeesNo(),
                          //     isActive: institutiondata.institution.isActive,
                          //   ),
                          // ),
                        ))
                    : Center(
                        child: TextButton.icon(
                        icon: Icon(Icons.add),
                        label: Text('Tab here to add Employees'),
                        style: TextButton.styleFrom(
                          primary: Color(0xff30384c),
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontStyle: FontStyle.italic),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageEmployees()),
                          ).then((value) => setState(() {}));
                        },
                      ));
          }),
    );
  }
}
