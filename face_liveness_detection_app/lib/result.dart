import 'dart:convert';
import 'package:http/http.dart';

Future getData(url) async {
  Uri uri = Uri.parse(url);
  //print('teeeeeeeeeeest' + uri.fragment);
  Response response = await get(uri);
  //print(response.statusCode);
  return response.body;
}
