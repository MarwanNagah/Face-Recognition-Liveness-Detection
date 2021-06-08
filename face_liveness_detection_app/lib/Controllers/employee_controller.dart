import 'package:face_liveness_detection_app/Models/client.dart' as cc;
import 'package:face_liveness_detection_app/Models/image.dart';
import 'dart:io';
import 'dart:ui';
import 'package:face_liveness_detection_app/Models/notification.dart';
import 'package:face_liveness_detection_app/Models/report.dart';

class EmployeeController {
  cc.Client employee;
  Image scannedImage;
  Notification empNotification;
  Report empReport;

  /*Future detectFaces(
      File pickedImage, List<Rect> rect, String url, String userID) {
    employee.detectFaces(pickedImage, rect, url, userID);
  }*/

  addImage() async {
    scannedImage.addImage();
  }

  addNotification(String institutionID) {
    empNotification.addNotification(institutionID);
  }

  addReport() async {
    empReport.addReport();
  }
}
