import 'package:face_liveness_detection_app/Models/HTTPException.dart';
import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:face_liveness_detection_app/Screens/Admin/ad_institution.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:face_liveness_detection_app/Models/institution.dart';

class InstitutionProvider with ChangeNotifier {
  final User user;

  Institution _institution;
  List<Institution> _institutions = [];

  Institution findById(String id) {
    return _institution;
  }

  Institution get institution {
    return _institution;
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
      _institutions.add(newInstitution);
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
}
