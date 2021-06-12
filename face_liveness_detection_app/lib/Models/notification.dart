import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Notification {
  String _id;
  String _userId;
  DateTime _date;
  bool _status;

  Notification({String id, String userID, DateTime date, bool status})
      : _id = id,
        _userId = userID,
        _date = date,
        _status = status;

  set id(String id) => _id = id;
  set userId(String userID) => _userId = userID;
  set date(DateTime date) => _date = date;
  set status(bool status) => _status = status;

  get status => _status;
  get date => _date;
  get userId => _userId;
  get id => _id;

  setDate() {
    _date = DateTime.now();
  }

  addNotification(String institutionID) {
    print('this is instittititt $institutionID ');
    setDate();
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$institutionID/notifications.json';
    Uri uri = Uri.parse(url);
    return http
        .post(uri,
            body: json.encode({
              'userID': this._userId,
              'date': this._date.toString(),
              'status': this._status,
            }))
        .catchError((error) {
      print(error);
    });
  }

  seenNotification(String institutionID, String notiID) {
    print('this is  $institutionID/////// $notiID ');
    final url =
        'https://face-liveness-detection-bca56-default-rtdb.firebaseio.com/institutions/$institutionID/notifications/$notiID.json';
    Uri uri = Uri.parse(url);
    return http
        .patch(uri,
            body: json.encode({
              'status': true,
            }))
        .catchError((error) {
      print(error);
    });
  }
}
