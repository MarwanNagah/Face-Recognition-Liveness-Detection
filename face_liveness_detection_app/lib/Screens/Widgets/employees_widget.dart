import 'package:flutter/material.dart';

class InstitutionEmployees extends StatefulWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String email;

  InstitutionEmployees({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
  }) {
    //print("ID: $id /// firstname : $firstname //// lastname : $lastname");
    print("emp widget");
  }

  @override
  _InstitutionEmployeesState createState() => _InstitutionEmployeesState(
      this.id, this.firstname, this.lastname, this.email);
}

class _InstitutionEmployeesState extends State<InstitutionEmployees> {
  final String id;
  final String firstname;
  final String lastname;
  final String email;

  _InstitutionEmployeesState(
      this.id, this.firstname, this.lastname, this.email);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[100],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('$firstname $lastname'),
            subtitle: Text('$email'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('DELETE'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Edit'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.greenAccent[400],
                ),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
