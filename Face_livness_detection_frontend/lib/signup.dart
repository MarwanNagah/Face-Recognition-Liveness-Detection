import 'package:flutter/material.dart';
import 'package:flutter_application_1/signin.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 110.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Sign",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Up',
                              style: TextStyle(color: Colors.greenAccent[400])),
                        ],
                      ),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.greenAccent[400],
                      child: Text('SignUp'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    )),
              ],
            )));
  }
}
