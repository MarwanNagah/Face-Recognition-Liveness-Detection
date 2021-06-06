import 'package:flutter/material.dart';

class ReportWidget extends StatefulWidget {
  final String reportID;
  final DateTime date;
  final bool status;
  final String userID;

  ReportWidget(
      {@required this.reportID,
      @required this.date,
      @required this.status,
      @required this.userID});

  @override
  _ReportWidgetState createState() => _ReportWidgetState(
      reportID: reportID, date: date, userID: userID, status: status);
}

class _ReportWidgetState extends State<ReportWidget> {
  final String reportID;
  final DateTime date;
  final bool status;
  final String userID;

  _ReportWidgetState(
      {@required this.reportID,
      @required this.date,
      @required this.status,
      @required this.userID});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        //padding: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            Text(
              '${date.toString()}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            Text(
              '$status',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
