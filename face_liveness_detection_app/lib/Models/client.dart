import 'dart:io';
import 'dart:ui';
import 'package:face_liveness_detection_app/Models/image.dart';
import 'package:face_liveness_detection_app/Models/report.dart';
import 'package:face_liveness_detection_app/Models/user.dart';
import 'dart:convert';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:face_liveness_detection_app/result.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;

class Client extends User {
  Report clientReport;
  void authenticate() {}

  Future uploadFile(File pickedImage, String url) async {
    await Firebase.initializeApp();
    FirebaseStorage storageReference = FirebaseStorage.instance;
    Reference ref = storageReference
        .ref()
        .child('/Face_Images/${Path.basename(pickedImage.path)}}');
    UploadTask uploadTask = ref.putFile(pickedImage);
    String imageURL;
    String tokenValue;
    String imagePath;
    await uploadTask.then((res) async {
      imageURL = await res.ref.getDownloadURL();
      Uri uri = Uri.parse(imageURL);
      tokenValue = uri.queryParameters['token'];
      imagePath =
          uri.pathSegments[4].substring(12, uri.pathSegments[4].length - 1);
      url += 'path=' + imagePath + '&token=' + tokenValue;
      clientReport.takenImage =
          Image(path: imageURL, height: 50.0, width: 50.0);
      await clientReport.takenImage.addImage();
    });
    return url;
  }

  Future getResult(String url) async {
    var data = await getData(url);
    var decodedData = jsonDecode(data);

    String finalResult = "";

    if (decodedData['result'] == "0") {
      finalResult = "Live";
      clientReport.status = true;
    } else {
      finalResult = "Spoof";
      clientReport.status = false;
    }
    await clientReport.addReport();
    return finalResult;
  }

  Future detectFaces(
      File pickedImage, List<Rect> rect, String url, String userID) async {
    clientReport = Report(userID: userID);
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(pickedImage);
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(myImage);

    if (rect.length > 0) {
      rect = [];
    }

    for (Face face in faces) {
      rect.add(face.boundingBox);
    }

    String newURL = await uploadFile(pickedImage, url);
    await getResult(newURL);

    return true;
  }
}
