import 'package:flutter/material.dart';
import 'package:face_liveness_detection_app/Models/notification.dart' as noti;

class NotficationWidget extends StatefulWidget {
  final String userId;
  final DateTime date;
  final bool status;

  NotficationWidget(
      {@required this.date, @required this.status, @required this.userId});

  @override
  _NotficationWidgetState createState() =>
      _NotficationWidgetState(date: date, userId: userId, status: status);
}

class _NotficationWidgetState extends State<NotficationWidget> {
  final String userId;
  final DateTime date;
  final bool status;

  _NotficationWidgetState(
      {@required this.date, @required this.status, @required this.userId});
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
