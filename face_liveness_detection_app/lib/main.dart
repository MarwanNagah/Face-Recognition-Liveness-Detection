import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:face_liveness_detection_app/result.dart';
//import 'faceDetection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FaceDetect(),
      theme: ThemeData.dark(),
    );
  }
}

class FaceDetect extends StatefulWidget {
  @override
  _FaceDetectState createState() => _FaceDetectState();
}

class _FaceDetectState extends State<FaceDetect> {
  File pickedImage;
  var imageFile;
  bool isImageLoaded = false;
  bool isFaceDetected = false;
  List<Rect> rect = [];
  String url='http://10.0.2.2:5000/';

  Future getResult() async {
    var data = await getData(url);
    var decodedData = jsonDecode(data);
    print(decodedData['query']);
  }

  _FaceDetectState(){
    getResult();
  }

  getImage() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.camera);
    imageFile = await tempStore.readAsBytes();
    imageFile = await decodeImageFromList(imageFile);

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      isFaceDetected = false;

      imageFile = imageFile;
    });
  }

  Future detectFaces() async {
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(pickedImage);
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(myImage);

    if (rect.length > 0) {
      rect = [];
    }

    for (Face face in faces) {
      rect.add(face.boundingBox);
    }

    setState(() {
      isFaceDetected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Detection"),
        actions: [
          FloatingActionButton(
            onPressed: getImage,
            child: Icon(
              Icons.add_a_photo,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          isImageLoaded && !isFaceDetected
              ? Center(
                  child: Container(
                    height: 250.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(pickedImage), fit: BoxFit.cover)),
                  ),
                )
              : isImageLoaded && isFaceDetected
                  ? Center(
                      child: Container(
                      child: FittedBox(
                        child: SizedBox(
                          width: imageFile.width.toDouble(),
                          height: imageFile.height.toDouble(),
                          child: CustomPaint(
                            painter:
                                FacePainter(rect: rect, imageFile: imageFile),
                          ),
                        ),
                      ),
                    ))
                  : Container()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          detectFaces();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  List<Rect> rect;
  var imageFile;

  FacePainter({@required this.rect, @required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }

    for (Rect rectangle in rect) {
      canvas.drawRect(
        rectangle,
        Paint()
          ..color = Colors.teal
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
