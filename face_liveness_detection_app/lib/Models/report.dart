import 'dart:convert';

import 'image.dart';
import 'package:http/http.dart' as http;

class Report {
  String reportID;
  DateTime reportDate;
  Image takenImage;
  bool status;
  String userID;

  Report(
      {this.reportDate,
      this.reportID,
      this.status,
      this.takenImage,
      this.userID});

  setDate() {
    reportDate = DateTime.now();
  }

  addReport() async {
    setDate();
    var id = this.userID;
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/users/$id/Report.json';
    Uri uri = Uri.parse(url);
    final response = await http
        .post(uri,
            body: json.encode({
              'ReportDate': this.reportDate.toString(),
              'Status': this.status,
              'imageID': this.takenImage.imageID,
            }))
        .catchError((error) {
      print(error);
    });
    this.reportID = json.decode(response.body)['name'];
  }
}
