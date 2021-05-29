import 'dart:convert';
import 'package:http/http.dart' as http;

class UserType {
  int userTypeID;
  String userTypeName;
  String keyF;

  UserType({this.userTypeID, this.userTypeName, this.keyF});

  addType() async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/userType.json';
    Uri uri = Uri.parse(url);
    return http
        .post(uri,
            body: json.encode({
              'userTypeID': this.userTypeID,
              'userTypeName': this.userTypeName,
              'isDeleted': 0,
            }))
        .catchError((error) {
      print(error);
    });
  }

  Future<void> readUserTypes() async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/userType.json';
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      final dbData = json.decode(response.body) as Map<String, dynamic>;
      dbData.forEach((key, value) {
        if (value['isDeleted'] == 0) {
          this.keyF = key;
          this.userTypeID = value['userTypeID'];
          this.userTypeName = value['userTypeName'];
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
