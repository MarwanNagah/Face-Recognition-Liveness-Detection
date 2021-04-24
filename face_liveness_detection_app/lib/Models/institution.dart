import 'package:face_liveness_detection_app/Models/user.dart';

class Institution {
  String id;
  String institutionName;
  int employeesNumber;
  String appusage;
  bool isActive;

  List<User> employees;

  Institution(
      {this.id,
      this.institutionName,
      this.employeesNumber,
      this.appusage,
      this.isActive,
      this.employees}) {
    this.employees = [];
  }

  Map<String, dynamic> get map {
    return {
      "institutionid": id,
      "institutionName": institutionName,
      "emplyeesNo": employeesNumber,
      "appUsage": appusage,
      "isActive": isActive,
      "employees": employees,
    };
  }
}
