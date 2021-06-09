import 'package:face_liveness_detection_app/Models/client.dart';
import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:face_liveness_detection_app/Controllers/institutionProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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
  final dateFormat = DateFormat('EEEE dd-MMMM-yyyy hh:mm');

  _ReportWidgetState(
      {@required this.reportID,
      @required this.date,
      @required this.status,
      @required this.userID,
      @required this.img}) {
    repClient = new Client(new User(uid: this.userID, fUser: null));
    this.readUser();
  }

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1)}";
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
            child: ListTile(
                leading: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(img.imagePath),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) {
                              return DetailScreen();
                            },
                            settings: RouteSettings(arguments: img.imagePath)));
                  },
                ),
                title: Text(
                  "${capitalize(repClient.firstName)} ${capitalize(repClient.lastName)}",
                  style: (TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    //color: Colors.white,
                  )),
                ),
                subtitle: Text(
                  '${dateFormat.format(date)}',
                  style: (TextStyle(
                    fontSize: 15,
                    //fontWeight: FontWeight.bold,
                    //color: Colors.white,
                  )),
                ),
                trailing: status
                    ? Text(
                        'Live',
                        style: (TextStyle(
                          fontSize: 20,
                          //fontWeight: FontWeight.bold,
                          color: Colors.greenAccent[400],
                        )),
                      )
                    : Text(
                        'Spoof',
                        style: (TextStyle(
                          fontSize: 20,
                          //fontWeight: FontWeight.bold,
                          color: Colors.redAccent[400],
                        )),
                      )),
          );
    // Card(
    //     elevation: 10.0,
    //     margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    //     child: Container(
    //       //padding: const EdgeInsets.only(right: 12.0),
    //       child: Column(
    //         children: [
    //           Text(
    //             '${date.toString()}',
    //             style: TextStyle(
    //                 color: Colors.black,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 18.0),
    //           ),
    //           Text(
    //             '${repClient.firstName}',
    //             style: TextStyle(
    //                 color: Colors.black,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 18.0),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    /*
          Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            "Report",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                  CupertinoIcons.person_alt_circle,
                                  color: Colors.greenAccent[400],
                                  size: 30,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Abdelrahman",
                                      style: (TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Date :  12/4/2021",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 60),
                                child: Text(
                                  "Spoof",
                                  style: (TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                            ],
                          ),
                        )
                      ])
          
          
          */
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String image = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              image,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
