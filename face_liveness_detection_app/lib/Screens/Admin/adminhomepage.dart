import 'package:face_liveness_detection_app/Models/institution.dart';
import 'package:face_liveness_detection_app/Providers/institutionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:face_liveness_detection_app/Screens/Widgets/notification_widget.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    refresh(context);
  }

  Future<void> refresh(BuildContext context) async {
    await Provider.of<InstitutionProvider>(context, listen: false)
        .fetchInstitutionNotifications();
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
                : RefreshIndicator(
                    onRefresh: () => refresh(context),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Consumer<InstitutionProvider>(
                          builder: (context, notificationData, child) =>
                              ListView.builder(
                                itemCount: notificationData
                                    .institutionNotifications.length,
                                itemBuilder: (_, i) => Column(
                                  children: [
                                    NotficationWidget(
                                      date: notificationData
                                          .institutionNotifications[i].date,
                                      userId: notificationData
                                          .institutionNotifications[i].userId,
                                      status: notificationData
                                          .institutionNotifications[i].status,
                                    )
                                  ],
                                ),
                              )
                          /*ManagerInstitution(
                          isTest: testChange,
                          id: institutiondata.institution.id,
                          institutionName:
                              institutiondata.institution.institutionName,
                          appusage: institutiondata.institution.appusage,
                          employeesNumber:
                              institutiondata.institution.getEmployeesNo(),
                          isActive: institutiondata.institution.isActive,
                        ),*/
                          ),
                    ));
          }),
    );
  }
}
