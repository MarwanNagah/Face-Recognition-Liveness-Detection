import 'dart:collection';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final String uid;
  final auth.User fUser;
  String token;
  String fireID;
  String firstName;
  String lastName;
  String eMail;
  String userType;

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
    final url = 'https://carqr-e4c82-default-rtdb.firebaseio.com/users.json';
    Uri uri = Uri.parse(url);
    return http
        .post(uri,
            body: json.encode({
              'uid': this.uid,
              'firstname': this.firstName,
              'lastName': this.lastName,
              'eMail': this.eMail,
              'usertype': this.userType,
            }))
        .catchError((error) {
      print(error);
    });
  }

  Future<void> readUser() async {
    final url = 'https://carqr-e4c82-default-rtdb.firebaseio.com/users.json';
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, value) {
        if (value['uid'] == this.uid) {
          this.fireID = key;
          this.eMail = value['eMail'];
          this.firstName = value['firstname'];
          this.lastName = value['lastName'];
          this.userType = value['usertype'];
          print("This is ${this.eMail}");
          return this;
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
