import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Adminpage extends StatefulWidget {
  @override
  _AdminpageState createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  CalendarController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Admin Page'),
        backgroundColor: Color(0xff30384c),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
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

            // Container(
            //     height: 90,
            //     padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
            //     child: RaisedButton(
            //       textColor: Colors.white,
            //       color: Colors.greenAccent[400],
            //       child: Text('Add User'),
            //       onPressed: () {},
            //     )),
            // Container(
            //     height: 90,
            //     padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
            //     child: RaisedButton(
            //       textColor: Colors.white,
            //       color: Colors.greenAccent[400],
            //       child: Text('Edit'),
            //       onPressed: () {},
            //     )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff30384c),
        fixedColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text("Notification"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            title: Text("Institution"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recent_actors_sharp),
            title: Text("Report"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text("Add User"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            title: Text("Edit users"),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
