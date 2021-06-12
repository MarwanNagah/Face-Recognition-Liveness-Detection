import 'dart:io';
import 'package:face_liveness_detection_app/Models/client.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:face_liveness_detection_app/Controllers/auth.dart';

class FaceDetect extends StatefulWidget {
  static String finalResult = "Loading...";
  final Client loggedUser;
  static List<Rect> rect = [];

  FaceDetect({@required this.loggedUser});

  @override
  _FaceDetectState createState() => _FaceDetectState(loggedUser: loggedUser);
}

class _FaceDetectState extends State<FaceDetect> {
  File pickedImage;
  var imageFile;
  bool isImageLoaded = false;
  bool isFaceDetected = false;
  bool isResultHere = false;
  String url = 'http://192.168.1.15:5000/api?';
  String imageURL;
  String imagePath;
  String tokenValue;

  final AuthService _auth = AuthService();

  final Client loggedUser;

  changeIsResultHere() {
    setState(() {
      isResultHere = !isResultHere;
    });
  }

  changeIsFaceDetected() {
    setState(() {
      isFaceDetected = !isFaceDetected;
    });
  }

  _FaceDetectState({@required this.loggedUser});

  getImage() async {
    setState(() {
      isImageLoaded = false;
      isFaceDetected = false;
      isResultHere = false;
      url = 'http://192.168.1.5:5000/api?';
    });
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = await tempStore.readAsBytes();
    imageFile = await decodeImageFromList(imageFile);
    print(imageFile.toString());

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      isFaceDetected = false;

      imageFile = imageFile;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Result"),
      content: Text(FaceDetect.finalResult),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff30384c),
        title: Text("Face Detection"),
        actions: [
          FloatingActionButton(
            backgroundColor: Color(0xff30384c),
            onPressed: getImage,
            child: Icon(
              Icons.upload_file,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
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
              : isImageLoaded && isFaceDetected && isResultHere
                  ? Center(
                      child: Column(children: [
                      Container(
                        child: FittedBox(
                          child: SizedBox(
                            width: imageFile.width.toDouble(),
                            height: imageFile.height.toDouble(),
                            child: CustomPaint(
                              painter: FacePainter(
                                  rect: FaceDetect.rect, imageFile: imageFile),
                            ),
                          ),
                        ),
                      ),
                    ]))
                  : Container()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff30384c),
        onPressed: () async {
          var result = await loggedUser.detectFaces(
              pickedImage,
              url,
              loggedUser.fireID,
              this.changeIsResultHere,
              this.changeIsFaceDetected);
          if (result) {
            showAlertDialog(context);
          } else {
            FaceDetect.finalResult =
                'System Detected an Error\nPlease take another image';
            showAlertDialog(context);
          }
          //detectFaces().then((value) => showAlertDialog(context));
          //_auth.signOut();
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
