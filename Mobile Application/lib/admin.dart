import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminState();
  }
}

class AdminState extends State<Admin> {
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
        elevation: 20,
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
              padding: EdgeInsets.fromLTRB(10, 180, 10, 80),
              alignment: Alignment.topCenter,
              child: Text("Number of users ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          Container(
              padding: EdgeInsets.fromLTRB(10, 240, 10, 80),
              alignment: Alignment.topCenter,
              child: Text("Logged Today : ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          Container(
              padding: EdgeInsets.fromLTRB(10, 300, 10, 80),
              alignment: Alignment.topCenter,
              child: Text("30 ",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold))),
          Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 80),
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                onPressed: () {},
                color: Colors.greenAccent[400],
                textColor: Colors.white,
                child: Text("Generat Report", style: TextStyle(fontSize: 15)),
                padding: EdgeInsets.all(50),
                shape: CircleBorder(),
              )),
          Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 50.0),
              child: RichText(
                text: TextSpan(
                  text: "Welcome",
                  style: TextStyle(color: Colors.black, fontSize: 40),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Admin',
                        style: TextStyle(color: Colors.greenAccent[400])),
                  ],
                ),
              )),
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
          onTap: () {},
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
          leading: Icon(Icons.settings),
          title: Text('Settings'),
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
