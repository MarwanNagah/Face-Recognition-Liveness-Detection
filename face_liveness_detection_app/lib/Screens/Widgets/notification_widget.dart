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
      color: Colors.blueGrey[100],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Mohamed Gamal'),
            subtitle: Text(
                'is trying to use the application but the result is spoof\nDate: ${date.day}/${date.month}/${date.year} time :${date.hour}:${date.minute} '),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.remove_red_eye),
                
                tooltip: 'mark as seen',
                
                onPressed: () {
                  setState(() {});
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
