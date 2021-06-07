import 'package:face_liveness_detection_app/Models/HTTPException.dart';
import 'package:face_liveness_detection_app/Models/client.dart' as cc;
import 'package:face_liveness_detection_app/Models/report.dart';
import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:face_liveness_detection_app/Screens/Admin/ad_institution.dart';
import 'package:face_liveness_detection_app/Screens/Admin/employees.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:face_liveness_detection_app/Models/institution.dart';
import 'package:face_liveness_detection_app/Models/notification.dart' as noti;
import 'package:face_liveness_detection_app/Models/image.dart' as img;

class InstitutionProvider with ChangeNotifier {
  final User user;

  Institution _institution;
  Institution _institutionemp;
  //List<Institution> _institutions = [];

  List<noti.Notification> _institutionNotifications = [];

  List<Report> institutionReports = [];

  cc.Client findClientById(String id) {
    return _institution.employees.firstWhere((client) => client.uid == id);
  }

  Institution findById(String id) {
    return _institution;
  }

  Future<User> findEmployeeById(String id) async {
    return _institution.employees.firstWhere((employee) => employee.uid == id);
  }

  Institution get institution {
    return _institution;
  }

  Institution get institutionemp {
    return _institutionemp;
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
          );
        }
      });
      _institution = dbInstitution;
      _institutionemp = dbInstitution;
      AdminInstitutionSc.isloading = true;
      notifyListeners();
      if (_institution == null) {
        AdminInstitutionSc.isloading = false;
      }
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> fetchEmployeesNo(String test) async {
    if (_institutionemp == null) {
      await this.fetchInstitution();
    }
    String id = _institution.id;

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
      _institutionemp.employees = InEmployees;

      print("done");
      EmployeesSc.isloading = true;
      //print(EmployeesSc.isloading);
      notifyListeners();
      if (_institutionemp.employees == null) {
        print("true");
        EmployeesSc.isloading = false;
      }
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
        for (int i = 0; i < _institutionemp.employees.length; i++) {
          if (data['uid'] == _institutionemp.employees[i].uid) {
            employees.add(cc.Client(User(
                uid: key,
                fUser: null,
                firstName: data['firstname'],
                lastName: data['lastName'],
                eMail: data['eMail'])));
          }
        }
      });

      _institutionemp.employees = employees;
      EmployeesSc.isloading = true;
      notifyListeners();
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

  void fetchReports() async {
    if (_institution.employees.isEmpty) {
      await this.fetchInstitution();
      await this.fetchEmployeesNo(_institution.id);
      await this.fetchusers();
    }
    print('test11111 ${_institution.employees.length}');
    var clientsSize = _institution.employees.length;

    List<Report> temp = [];

    institutionReports = [];

    for (int i = 0; i < clientsSize; i++) {
      print(i + 5000);
      var id = _institution.employees[i].uid;

      await fetchIndvidualReportClient(id);
    }

    print(institutionReports.length);
  }

  fetchIndvidualReportClient(String clientID) async {
    print(clientID);
    var url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/users/$clientID/Report.json';
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final dbData = json.decode(response.body) as Map<String, dynamic>;

      print(dbData);

      if (dbData == null) {
        return;
      }

      dbData.forEach((key, data) {
        institutionReports.add(new Report(
          reportID: key,
          reportDate: DateTime.parse(data['ReportDate']),
          status: data['Status'],
          takenImage: new img.Image(imageID: data['imageID']),
          userID: clientID,
        ));
      });
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
