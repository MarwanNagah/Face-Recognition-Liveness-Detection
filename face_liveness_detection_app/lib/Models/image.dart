import 'dart:convert';
import 'package:http/http.dart' as http;

class Image {
  String _imageID;
  String _path;
  double _width;
  double _height;

  Image({String imageID = "", String path, double width, double height}) {
    this._imageID = imageID;
    this._height = height;
    this._width = width;
    this._path = path;

    if (imageID != "") {
      this.readImage();
    }
  }

  set imageID(String imageID) {
    this._imageID = imageID;
  }

  set path(String path) {
    this._path = path;
  }

  set width(double width) {
    this._width = width;
  }

  set height(double height) {
    this._height = height;
  }

  get imageID {
    return this._imageID;
  }

  get imagePath {
    return this._path;
  }

  get height {
    return this._height;
  }

  addImage() async {
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/images.json';
    Uri uri = Uri.parse(url);
    final response = await http
        .post(uri,
            body: json.encode({
              'path': this._path,
              'height': this._height,
              'width': this._width,
            }))
        .catchError((error) {
      print(error);
    });
    this._imageID = json.decode(response.body)['name'];
    print(this._imageID);
  }

  readImage() async {
    String id = this._imageID;
    var url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/images/$id.json';
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final dbData = json.decode(response.body) as Map<String, dynamic>;

      if (dbData == null) {
        return;
      }
      this._height = dbData['height'];
      this._width = dbData['width'];
      this._path = dbData['path'];
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
