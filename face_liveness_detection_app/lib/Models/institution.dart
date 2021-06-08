import 'package:face_liveness_detection_app/Models/client.dart';
import 'package:face_liveness_detection_app/Models/user.dart';

class Institution {
  String id;
  String institutionName;
  String appusage;
  bool isActive;

  List<Client> employees;

  Institution(
      {this.id,
      this.institutionName,
      this.appusage,
      this.isActive,
      this.employees}) {
    this.employees = [];
  }

  int getEmployeesNo() {
    return employees.length;
  }

  Map<String, dynamic> get map {
    return {
      "institutionid": id,
      "institutionName": institutionName,
      "appUsage": appusage,
      "isActive": isActive,
      "employees": employees,
    };
  }
}
