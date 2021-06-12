import 'package:face_liveness_detection_app/Models/client.dart';
import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:face_liveness_detection_app/Models/notification.dart' as noti;

class NotficationWidget extends StatefulWidget {
  // final String userId;
  // final DateTime date;
  // final bool status;
  final String institutionID;
  final noti.Notification resNOti;

  NotficationWidget({@required this.resNOti, @required this.institutionID});

  @override
  _NotficationWidgetState createState() =>
      _NotficationWidgetState(resNOti: resNOti, institutionID: institutionID);
}

class _NotficationWidgetState extends State<NotficationWidget> {
  // final String userId;
  // final DateTime date;
  // final bool status;
  final String institutionID;
  final noti.Notification resNOti;
  Client repClient;

  bool _isLoading = true;

  _NotficationWidgetState(
      {@required this.resNOti, @required this.institutionID}) {
    repClient = new Client(new User(uid: this.resNOti.userId, fUser: null));
    this.readUser();
  }

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1)}";
  }

  void readUser() async {
    await repClient.readUserByID(this.resNOti.userId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Text("")
        : Card(
            color: resNOti.status ? Colors.transparent : Colors.blueGrey[100],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                      '${capitalize(repClient.firstName)} ${capitalize(repClient.lastName)}'),
                  subtitle: Text(
                      'is trying to use the application but the result is spoof\nDate: ${this.resNOti.date.day}/${this.resNOti.date.month}/${this.resNOti.date.year} time :${this.resNOti.date.hour}:${this.resNOti.date.minute} '),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      tooltip: 'mark as seen',
                      onPressed: () {
                        resNOti.seenNotification(institutionID, resNOti.id);
                        setState(() {
                          resNOti.status = true;
                        });
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
