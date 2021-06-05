import 'package:face_liveness_detection_app/Models/institution.dart';
import 'package:face_liveness_detection_app/Providers/institutionProvider.dart';
import 'package:face_liveness_detection_app/Screens/Widgets/institution_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manage_institution.dart';

class AdminInstitutionSc extends StatefulWidget {
  static const routeName = '/admininstitution';
  static bool isloading = false;

  @override
  _AdminInstitutionScState createState() => _AdminInstitutionScState();
}

class _AdminInstitutionScState extends State<AdminInstitutionSc> {
  bool isTest = false;

  Future<void> refresh(BuildContext context) async {
    await Provider.of<InstitutionProvider>(context, listen: false)
        .fetchInstitution();
    Institution adInstitution =
        Provider.of<InstitutionProvider>(context, listen: false).institution;
    await Provider.of<InstitutionProvider>(context, listen: false)
        .fetchEmployeesNo(adInstitution.id);
    await Provider.of<InstitutionProvider>(context, listen: false).fetchusers();
    isTest = AdminInstitutionSc.isloading;
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
          future: refresh(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.greenAccent[400])),
                  )
                : isTest
                    ? RefreshIndicator(
                        onRefresh: () =>
                            refresh(context).then((value) => setState(() {})),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Consumer<InstitutionProvider>(
                            builder: (context, institutiondata, child) =>
                                ManagerInstitution(
                              isTest: testChange,
                              id: institutiondata.institution.id,
                              institutionName:
                                  institutiondata.institution.institutionName,
                              appusage: institutiondata.institution.appusage,
                              employeesNumber:
                                  institutiondata.institution.getEmployeesNo(),
                              isActive: institutiondata.institution.isActive,
                            ),
                          ),
                        ))
                    : Center(
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
                                    builder: (context) => ManageInstitution()),
                              ).then((value) => setState(() {}));
                            },
                          ),
                        ),
                      ));
          }),
    );
  }
}
