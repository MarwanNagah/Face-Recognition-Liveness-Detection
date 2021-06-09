import 'package:face_liveness_detection_app/Controllers/institutionProvider.dart';
import 'package:face_liveness_detection_app/Views/Admin/manage_employees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstitutionEmployees extends StatefulWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  Function isTest;

  InstitutionEmployees(
      {this.id, this.firstname, this.lastname, this.email, this.isTest});

  @override
  _InstitutionEmployeesState createState() => _InstitutionEmployeesState(
      this.id, this.firstname, this.lastname, this.email, this.isTest);
}

class _InstitutionEmployeesState extends State<InstitutionEmployees> {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  Function isTest;

  _InstitutionEmployeesState(
      this.id, this.firstname, this.lastname, this.email, this.isTest);

  Future<void> createDialog(BuildContext context) async {
    final scaffold = Scaffold.of(context);
    final prov = Provider.of<InstitutionProvider>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure you want to delete this employee ?"),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text("Submit"),
                onPressed: () async {
                  try {
                    prov.deleteInstitution(id);
                    isTest();
                    Navigator.of(context).pop();
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Deleting failed!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    print(error);
                  }
                },
              )
            ],
          );
        });
  }

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
              // TextButton(
              //   child: const Text('DELETE'),
              //   style: TextButton.styleFrom(
              //     primary: Colors.white,
              //     backgroundColor: Colors.red,
              //   ),
              //   onPressed: () {/* ... */},
              // ),
              const SizedBox(width: 8),
              // TextButton(
              //   child: const Text('Edit'),
              //   style: TextButton.styleFrom(
              //     primary: Colors.white,
              //     backgroundColor: Colors.greenAccent[400],
              //   ),
              //   onPressed: () {
              //     Provider.of<InstitutionProvider>(context, listen: false)
              //         .readUserbyID(id)
              //         .then((value) {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => ManageEmployees(),
              //             settings: RouteSettings(
              //               arguments: id,
              //             )),
              //       ).then((value) => setState(() {}));
              //     });

              //   },
              // ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
