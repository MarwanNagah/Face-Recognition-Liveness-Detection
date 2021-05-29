import 'dart:collection';
import 'dart:convert';

import 'package:face_liveness_detection_app/Models/userType.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserTypes with ChangeNotifier {
  List<UserType> _types = [];

  UnmodifiableListView<UserType> get allTypes => UnmodifiableListView(_types);

  Future<UserType> findById(int id) async {
    if (_types.isEmpty) {
      await readTypes();
    }
    return _types.firstWhere((type) => type.userTypeID == id);
  }

  Future<void> readTypes() async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/userType.json';
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      final dbData = json.decode(response.body) as Map<String, dynamic>;
      final List<UserType> dbTypes = [];
      dbData.forEach((key, data) async {
        dbTypes.add(UserType(
          keyF: key,
          userTypeID: data['userTypeID'],
          userTypeName: data['userTypeName'],
        ));
      });
      _types = dbTypes;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
