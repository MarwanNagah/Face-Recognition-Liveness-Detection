import 'package:face_liveness_detection_app/Models/HTTPException.dart';
import 'package:face_liveness_detection_app/Models/client.dart' as cc;
import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:face_liveness_detection_app/Screens/Admin/ad_institution.dart';
import 'package:face_liveness_detection_app/Screens/Admin/employees.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:face_liveness_detection_app/Models/institution.dart';
import 'package:face_liveness_detection_app/Models/notification.dart' as noti;

class InstitutionProvider with ChangeNotifier {
  final User user;

  Institution _institution;
  //List<Institution> _institutions = [];

  List<noti.Notification> _institutionNotifications = [];

  Institution findById(String id) {
    return _institution;
  }

  Future<User> findEmployeeById(String id) async {
    return _institution.employees.firstWhere((employee) => employee.uid == id);
  }

  Institution get institution {
    return _institution;
  }

  List<noti.Notification> get institutionNotifications {
    return [..._institutionNotifications];
  }

  InstitutionProvider({@required this.user});

  Future<Institution> fetchInstitution() async {
    var url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions.json';
    try {
      _institution = null;
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData == null) {
        return null;
      }
      Institution dbInstitution;
      dbData.forEach((key, data) {
        if (data['adminId'] == user.uid) {
          dbInstitution = new Institution(
            id: key,
            institutionName: data['institutionName'],
            appusage: data['appUsage'],
            isActive: data['isActive'],
            //employees: data['employees'],
          );
          _institution = dbInstitution;
          AdminInstitutionSc.isloading = true;
          notifyListeners();
          return dbInstitution;
        }
      });
      notifyListeners();
      if (_institution == null) {
        AdminInstitutionSc.isloading = false;
      }
      return null;
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  // Future<void> fetchEmployees() async {
  //   final url =
  //       'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions.json';

  //   try {
  //     Uri uri = Uri.parse(url);
  //     final response = await http.get(uri);
  //     final dbData = json.decode(response.body) as Map<String, dynamic>;
  //     if (dbData == null) {
  //       return null;
  //     }
  //     String institutionID;
  //     dbData.forEach((key, data) {
  //       if (data['adminId'] == user.uid) {
  //         institutionID = key;
  //       }
  //     });
  //     final url2 =
  //         'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$institutionID/employees.json';
  //     Uri uri2 = Uri.parse(url2);
  //     final response2 = await http.get(uri2);
  //     final dbData2 = json.decode(response2.body) as Map<String, dynamic>;
  //     if (dbData2 == null) {
  //       return null;
  //     }
  //     List<User> InEmployees = [];
  //     dbData.forEach((key, data) {
  //       InEmployees.add(User(uid: data['employeeID'], fUser: null));

  //       _institution.employees = InEmployees;
  //       EmployeesSc.isloading = true;
  //       notifyListeners();
  //       return InEmployees;
  //     });
  //     notifyListeners();
  //     if (_institution.employees == null) {
  //       EmployeesSc.isloading = false;
  //     }
  //     return null;
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     throw (e);
  //   }
  // }

  Future<void> fetchEmployeesNo(String id) async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$id/employees.json';

    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData == null) {
        return null;
      }
      List<cc.Client> InEmployees = [];
      dbData.forEach((key, data) {
        InEmployees.add(cc.Client(User(uid: data['employeeID'], fUser: null)));
      });
      _institution.employees = InEmployees;
      EmployeesSc.isloading = true;
      notifyListeners();
      if (_institution.employees == null) {
        EmployeesSc.isloading = false;
      }
      return null;
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> fetchusers() async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/users.json';

    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      if (dbData == null) {
        return null;
      }

      List<cc.Client> employees = [];

      dbData.forEach((key, data) {
        for (int i = 0; i < _institution.employees.length; i++) {
          if (data['uid'] == _institution.employees[i].uid) {
            employees.add(cc.Client(User(
                uid: key,
                fUser: null,
                firstName: data['firstname'],
                lastName: data['lastName'],
                eMail: data['eMail'])));
          }
        }
      });
      _institution.employees = employees;

      notifyListeners();
      return employees;
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> addInstitution(Institution institution) async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions.json';

    try {
      Uri uri = Uri.parse(url);

      final response = await http.post(uri,
          body: json.encode({
            'institutionName': institution.institutionName,
            'appUsage': institution.appusage,
            'isActive': institution.isActive,
            'adminId': user.uid,
          }));

      final newInstitution = Institution(
          institutionName: institution.institutionName,
          appusage: institution.appusage,
          isActive: institution.isActive,
          employees: institution.employees,
          id: json.decode(response.body)['name']);
      _institution = newInstitution;
      AdminInstitutionSc.isloading = true;
      // _institutions.add(newInstitution);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addEmployeeToInstitution(String id, User employee) async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$id/employees.json';

    try {
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: json.encode({
            'employeeID': employee.uid,
          }));

      _institution.employees.add(employee);
      EmployeesSc.isloading = true;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateInstitution(String id, Institution newInstitution) async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$id.json';
    try {
      Uri uri = Uri.parse(url);
      await http.patch(uri,
          body: json.encode({
            'institutionName': newInstitution.institutionName,
            'appUsage': newInstitution.appusage,
            'isActive': newInstitution.isActive,
          }));
      _institution = newInstitution;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteInstitution(String id) async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$id.json';
    var exisitingInstitution = _institution;
    _institution = null;
    AdminInstitutionSc.isloading = false;
    notifyListeners();
    Uri uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode >= 400) {
      print("response Code : ${response.statusCode}");
      AdminInstitutionSc.isloading = true;
      _institution = exisitingInstitution;
      notifyListeners();
      throw HTTPException('Delete failed for showroom whose id is $id');
    }
    exisitingInstitution = null;
  }

  Future<void> fetchInstitutionNotifications() async {
    var id = _institution.id;
    var url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$id/notifications.json';
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final dbData = json.decode(response.body) as Map<String, dynamic>;

      if (dbData == null) {
        return;
      }

      List<noti.Notification> temp = [];
      dbData.forEach((key, data) {
        temp.add(new noti.Notification(
            id: key,
            date: DateTime.parse(data['date']),
            status: data['status'],
            userID: data['userID']));
      });
      _institutionNotifications = temp;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> fetchInstitutionReports() async {
    var id = _institution.id;
    var url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$id/notifications.json';
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final dbData = json.decode(response.body) as Map<String, dynamic>;

      if (dbData == null) {
        return;
      }

      List<noti.Notification> temp = [];
      dbData.forEach((key, data) {
        temp.add(new noti.Notification(
            id: key,
            date: DateTime.parse(data['date']),
            status: data['status'],
            userID: data['userID']));
      });
      _institutionNotifications = temp;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
