import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:face_liveness_detection_app/Providers/user_types.dart';
import 'package:face_liveness_detection_app/Screens/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:face_liveness_detection_app/result.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import 'package:face_liveness_detection_app/Screens/wrapper.dart';

import 'Models/user.dart';
import 'Providers/auth.dart';
//import 'faceDetection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

class Nav extends StatelessWidget {
  final User loggedUser;

  Nav({@required this.loggedUser});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserTypes>(
          create: (context) => UserTypes(),
        )
      ],
      child: MaterialApp(
        routes: {
          '/': (ctx) => PageNavigator(
                loggedUser: loggedUser,
              ),
        },
      ),
    );
  }
}

class PageNavigator extends StatefulWidget {
  final User loggedUser;

  PageNavigator({@required this.loggedUser});
  @override
  _PageNavigatorState createState() =>
      _PageNavigatorState(loggedUser: loggedUser);
}

class _PageNavigatorState extends State<PageNavigator> {
  final User loggedUser;
  bool _isLoaded = false;
  dynamic initialPage;

  _PageNavigatorState({@required this.loggedUser});

  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    await loggedUser.readUser();
    Future.delayed(const Duration(seconds: 1), () {
      if (loggedUser.userType.userTypeName == "Client") {
        //page for client
        initialPage = FaceDetect(loggedUser: loggedUser);
      } else if (loggedUser.userType.userTypeName == "Manager") {
        //page for manager
        initialPage = Loading();
      } else {
        //page for admin
        initialPage = Loading();
      }
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoaded ? Loading() : initialPage;
  }
}

class FaceDetect extends StatefulWidget {
  final User loggedUser;

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
  List<Rect> rect = [];
  String url = 'http://10.0.2.2:5000/api?';
  String imageURL;
  String imagePath;
  String tokenValue;
  String finalResult = "Loading...";
  final AuthService _auth = AuthService();

  final User loggedUser;

  _FaceDetectState({@required this.loggedUser});

  Future uploadFile() async {
    await Firebase.initializeApp();
    FirebaseStorage storageReference = FirebaseStorage.instance;
    Reference ref = storageReference
        .ref()
        .child('/Face_Images/${Path.basename(pickedImage.path)}}');
    UploadTask uploadTask = ref.putFile(pickedImage);
    await uploadTask.then((res) async {
      imageURL = await res.ref.getDownloadURL();
      Uri uri = Uri.parse(imageURL);
      tokenValue = uri.queryParameters['token'];
      imagePath =
          uri.pathSegments[4].substring(12, uri.pathSegments[4].length - 1);
      url += 'path=' + imagePath + '&token=' + tokenValue;
      print('File Uploaded');
    });
  }

  Future getResult() async {
    var data = await getData(url);
    var decodedData = jsonDecode(data);

    if (decodedData['result'] == "0") {
      finalResult = "Live";
    } else {
      finalResult = "Spoof";
    }

    setState(() {
      isResultHere = true;
    });
    print(decodedData['result']);
  }

  getImage() async {
    setState(() {
      isImageLoaded = false;
      isFaceDetected = false;
      isResultHere = false;
      url = 'http://10.0.2.2:5000/api?';
    });
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
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
    await uploadFile();
    await getResult();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Result"),
      content: Text(finalResult),
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
                              painter:
                                  FacePainter(rect: rect, imageFile: imageFile),
                            ),
                          ),
                        ),
                      ),
                    ]))
                  : Container()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //detectFaces().then((value) => showAlertDialog(context));
          _auth.signOut();
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
