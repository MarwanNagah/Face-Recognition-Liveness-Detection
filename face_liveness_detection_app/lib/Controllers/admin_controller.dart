import 'package:face_liveness_detection_app/Models/client.dart' as cc;
import 'package:face_liveness_detection_app/Models/image.dart';
import 'dart:io';
import 'dart:ui';
import 'package:face_liveness_detection_app/Models/notification.dart';
import 'package:face_liveness_detection_app/Models/report.dart';

class AdminController {
  cc.Client employee;
  Image scannedImage;
  Notification empNotification;
  Report empReport;

  readImage() async {
    scannedImage.readImage();
  }
}
