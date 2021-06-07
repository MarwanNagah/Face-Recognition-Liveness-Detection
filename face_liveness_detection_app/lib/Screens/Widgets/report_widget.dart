import 'package:face_liveness_detection_app/Models/client.dart';
import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:face_liveness_detection_app/Providers/institutionProvider.dart';
import 'package:flutter/material.dart';
import 'package:face_liveness_detection_app/Models/image.dart' as image;
import 'package:provider/provider.dart';

class ReportWidget extends StatefulWidget {
  final String reportID;
  final DateTime date;
  final bool status;
  final String userID;
  final image.Image img;

  ReportWidget(
      {@required this.reportID,
      @required this.date,
      @required this.status,
      @required this.userID,
      @required this.img});

  @override
  _ReportWidgetState createState() => _ReportWidgetState(
      reportID: reportID, date: date, userID: userID, status: status, img: img);
}

class _ReportWidgetState extends State<ReportWidget> {
  final String reportID;
  final DateTime date;
  final bool status;
  final String userID;
  final image.Image img;
  Client repClient;

  bool _isLoading = true;

  _ReportWidgetState(
      {@required this.reportID,
      @required this.date,
      @required this.status,
      @required this.userID,
      @required this.img}) {
    repClient = new Client(new User(uid: this.userID, fUser: null));
    this.readUser();
  }

  void readUser() async {
    await repClient.readUserByID(this.userID);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : Card(
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
                    '${repClient.firstName}',
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
