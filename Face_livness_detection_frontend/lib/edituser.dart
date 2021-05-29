import 'package:flutter/material.dart';
import 'package:flutter_application_1/signin.dart';

class EdituserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<EdituserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' Edit User'),
          backgroundColor: Color(0xff30384c),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 51.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Edit ",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'User',
                              style: TextStyle(color: Colors.greenAccent[400])),
                        ],
                      ),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'Name',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'E-mail',
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'User Name',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      labelText: 'Conferm Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
                  child: OutlineButton(
                      onPressed: () => null,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Icon(Icons.camera_alt),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Upload image'),
                            ],
                          ),
                        ],
                      ),
                      highlightedBorderColor: Colors.green,
                      color: Colors.green,
                      borderSide: new BorderSide(color: Colors.green),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0))),
                ),
              ],
            )),
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
        ));
  }
}
