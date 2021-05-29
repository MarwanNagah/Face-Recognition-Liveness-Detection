import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: <Widget>[
            Container(
              child: TableCalendar(
                calendarStyle: CalendarStyle(
                  todayColor: Colors.greenAccent[400],
                  selectedColor: Color(0xff30384c),
                ),
                calendarController: _controller,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular((50)),
                      topRight: Radius.circular(50)),
                  color: Color(0xff30384c)),
              child: Stack(
                children: <Widget>[
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
