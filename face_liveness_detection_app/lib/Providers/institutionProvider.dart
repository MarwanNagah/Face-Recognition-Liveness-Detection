import 'package:face_liveness_detection_app/Models/HTTPException.dart';
import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:face_liveness_detection_app/Models/institution.dart';

class InstitutionProvider with ChangeNotifier {
  final User user;

  Institution _institution;
  List<Institution> _institutions = [];

  InstitutionProvider({@required this.user});

  Future<Institution> fetchInstitution() async {
    var url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions.json?auth=${user.token}';
    try {
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
            employeesNumber: data['emplyeesNo'],
            appusage: data['appUsage'],
            isActive: data['isActive'],
          );
          _institution = dbInstitution;
          notifyListeners();
          return dbInstitution;
        }
      });
      notifyListeners();
      return null;
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> addInstitution(Institution institution) async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions.json?auth=${user.token}';

    try {
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: json.encode({
            'institutionName': institution.institutionName,
            'emplyeesNo': institution.employeesNumber,
            'appUsage': institution.appusage,
            'isActive': institution.isActive,
            'adminId': user.uid,
          }));

      final newInstitution = Institution(
          institutionName: institution.institutionName,
          employeesNumber: institution.employeesNumber,
          appusage: institution.appusage,
          isActive: institution.isActive,
          id: json.decode(response.body)['name']);
      _institution = newInstitution;
      _institutions.add(newInstitution);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateInstitution(String id, Institution newInstitution) async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$id.json?auth=${user.token}';
    try {
      Uri uri = Uri.parse(url);
      await http.patch(uri,
          body: json.encode({
            'institutionName': newInstitution.institutionName,
            'emplyeesNo': newInstitution.employeesNumber,
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
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$id.json?auth=${user.token}';
    var exisitingInstitution = _institution;
    _institution = null;
    notifyListeners();
    Uri uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode >= 400) {
      print("response Code : ${response.statusCode}");
      _institution = exisitingInstitution;
      notifyListeners();
      throw HTTPException('Delete failed for showroom whose id is $id');
    }
    exisitingInstitution = null;
  }
}
