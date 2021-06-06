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
      elevation: 10.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        //padding: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            Text(
              '$firstname  $lastname',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            Text(
              '$email',
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
