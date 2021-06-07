import 'dart:collection';
import 'dart:convert';
import 'package:face_liveness_detection_app/Models/userType.dart';
import 'package:face_liveness_detection_app/Providers/user_types.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class User {
  final String uid;
  final auth.User fUser;
  String token;
  String fireID;
  String firstName;
  String lastName;
  String eMail;
  UserType userType;
  String institutionID;

  User({
    @required this.uid,
    @required this.fUser,
    this.token,
    this.fireID,
    this.firstName,
    this.lastName,
    this.eMail,
    this.userType,
  });

  User.constructUser(
      {@required this.uid, @required this.fUser, @required User user}) {
    this.token = user.uid;
    this.fireID = user.fireID;
    this.firstName = user.firstName;
    this.lastName = user.lastName;
    this.eMail = user.eMail;
    this.userType = user.userType;
    this.institutionID = user.institutionID;
  }

  Map<String, dynamic> get map {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "eMail": eMail,
      "usertype": userType,
      "fUser": fUser,
      "token": token,
    };
  }

  register() async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/users.json';
    Uri uri = Uri.parse(url);
    return http
        .post(uri,
            body: json.encode({
              'uid': this.uid,
              'firstname': this.firstName,
              'lastName': this.lastName,
              'eMail': this.eMail,
              'usertype': this.userType.userTypeID,
            }))
        .catchError((error) {
      print(error);
    });
  }

  Future<void> readUser() async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/users.json';
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, value) async {
        if (value['uid'] == this.uid) {
          readType(value['usertype']);
          this.fireID = key;
          this.eMail = value['eMail'];
          this.firstName = value['firstname'];
          this.lastName = value['lastName'];
          return this;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  readUserByID(String id) async {
    print('this is user being read');
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/users/$id.json';
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      final dbData = json.decode(response.body) as Map<String, dynamic>;

      readType(dbData['usertype']);
      this.eMail = dbData['eMail'];
      this.firstName = dbData['firstname'];
      this.lastName = dbData['lastName'];
    } catch (e) {
      print(e);
    }
  }

  Future<UserType> readType(int id) async {
    final UserTypes temp = UserTypes();
    UserType type = await temp.findById(id);
    this.userType = type;
    return type;
  }

  readInstitution() async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/users/$fireID.json';
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      final dbData = json.decode(response.body) as Map<String, dynamic>;
      this.institutionID = dbData['institutionID'];
      print(this.institutionID);
    } catch (e) {
      print(e);
    }
  }
}
