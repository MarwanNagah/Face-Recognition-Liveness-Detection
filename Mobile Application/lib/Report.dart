import 'package:flutter/material.dart';
import 'package:getflutter/components/rating/gf_rating.dart';

class Report extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReportState();
  }
}

class ReportState extends State<Report> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _rating = 1;
  double count = 1;

  get rating => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin",
          style: TextStyle(fontSize: 25),
        ),
        elevation: 10,
        backgroundColor: Colors.greenAccent[400],
        actions: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 120, 10, 10),
            child: Table(
              border: TableBorder.all(width: 1, color: Colors.black),
              children: [
                TableRow(children: [
                  Column(children: [
                    Icon(Icons.person, size: 30),
                    Text('Abdelrahman Ashraf')
                  ]),
                  Column(children: [
                    Icon(Icons.account_box, size: 30),
                    Text('Accepted')
                  ]),
                  Column(children: [
                    Icon(Icons.date_range, size: 30),
                    Text('15/12/2020')
                  ]),
                  Column(children: [
                    Icon(Icons.access_time, size: 30),
                    Text('11:18:00')
                  ]),
                ]),
                TableRow(children: [
                  Column(children: [
                    Icon(Icons.person, size: 30),
                    Text('Marwan Mohamed')
                  ]),
                  Column(children: [
                    Icon(Icons.account_box, size: 30),
                    Text('Denied')
                  ]),
                  Column(children: [
                    Icon(Icons.date_range, size: 30),
                    Text('12/11/2020')
                  ]),
                  Column(children: [
                    Icon(Icons.access_time, size: 30),
                    Text('8:30:00')
                  ]),
                ]),
                TableRow(children: [
                  Column(children: [
                    Icon(Icons.person, size: 30),
                    Text('Mohamed Gamal')
                  ]),
                  Column(children: [
                    Icon(Icons.account_box, size: 30),
                    Text('Spoofed')
                  ]),
                  Column(children: [
                    Icon(Icons.date_range, size: 30),
                    Text('12/11/2020')
                  ]),
                  Column(children: [
                    Icon(Icons.access_time, size: 30),
                    Text('9:45:00')
                  ]),
                ]),
                TableRow(children: [
                  Column(children: [
                    Icon(Icons.person, size: 30),
                    Text('Mohamed Yasser')
                  ]),
                  Column(children: [
                    Icon(Icons.account_box, size: 30),
                    Text('Accepted')
                  ]),
                  Column(children: [
                    Icon(Icons.date_range, size: 30),
                    Text('13/12/2020')
                  ]),
                  Column(children: [
                    Icon(Icons.access_time, size: 30),
                    Text('10:15:00')
                  ]),
                ]),
                TableRow(children: [
                  Column(children: [
                    Icon(Icons.person, size: 30),
                    Text('Abdelrahman Ashraf')
                  ]),
                  Column(children: [
                    Icon(Icons.account_box, size: 30),
                    Text('Spoofed')
                  ]),
                  Column(children: [
                    Icon(Icons.date_range, size: 30),
                    Text('15/12/2020')
                  ]),
                  Column(children: [
                    Icon(Icons.access_time, size: 30),
                    Text('11:18:00')
                  ]),
                ]),
              ],
            ),
          ),
          Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 40.0),
              child: RichText(
                text: TextSpan(
                  text: "Report of ",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Institution',
                        style: TextStyle(color: Colors.greenAccent[400])),
                  ],
                ),
              )),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(80, 10, 80, 50),
            child: FlatButton(
              onPressed: () => {},
              color: Colors.greenAccent[400],
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.download_sharp),
                  Text("Download as PDF")
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        Container(
          height: 64.0,
          child: DrawerHeader(
            child: Text('Admin'),
            decoration: BoxDecoration(
              color: Colors.greenAccent[400],
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Add'),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Edit'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Delete'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {},
        ),
      ])),
    );
  }
}
