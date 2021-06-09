import 'package:face_liveness_detection_app/Controllers/institutionProvider.dart';
import 'package:face_liveness_detection_app/Views/Widgets/report_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_report_data.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  CalendarController _controller;
  DateTime _chosenDate = DateTime.now();
  final dateFormat = DateFormat('EEEE yyyy-MMMM-dd');
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Container(
              child: TableCalendar(
                initialSelectedDay: _chosenDate,
                onDaySelected: (date, events, e) {
                  setState(() {
                    _chosenDate = date;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayColor: Colors.greenAccent[400],
                  selectedColor: Color(0xff30384c),
                ),
                calendarController: _controller,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    dateFormat.format(_chosenDate),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.greenAccent[400],
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 150, height: 150),
                    child: MaterialButton(
                      color: Colors.greenAccent[400],
                      child: Text(
                        'Generate Report',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportData(),
                              settings: RouteSettings(
                                arguments: _chosenDate,
                              )),
                        ).then((value) => setState(() {}));
                      },
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // body: FutureBuilder<Object>(
      //     future: refresh(context),
      //     builder: (context, snapshot) {
      //       return snapshot.connectionState == ConnectionState.waiting
      //           ? Center(
      //               child: CircularProgressIndicator(
      //                   valueColor: new AlwaysStoppedAnimation<Color>(
      //                       Colors.greenAccent[400])),
      //             )
      //           : RefreshIndicator(
      //               onRefresh: () => refresh(context),
      //               child: Padding(
      //                 padding: EdgeInsets.all(8),
      //                 child: Consumer<InstitutionProvider>(
      //                     builder: (context, institution, child) =>
      //                         ListView.builder(
      //                           itemCount:
      //                               institution.institutionReports.length,
      //                           itemBuilder: (_, i) => Column(
      //                             children: [
      //                               ReportWidget(
      //                                 reportID: institution
      //                                     .institutionReports[i].reportID,
      //                                 date: institution
      //                                     .institutionReports[i].reportDate,
      //                                 status: institution
      //                                     .institutionReports[i].status,
      //                                 userID: institution
      //                                     .institutionReports[i].userID,
      //                                 img: institution
      //                                     .institutionReports[i].takenImage,
      //                               )
      //                             ],
      //                           ),
      //                         )),
      //               ));
      //     }),
    );
  }
}
