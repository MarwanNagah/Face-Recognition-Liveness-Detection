import 'package:http/http.dart';

Future getData(url) async {
  Uri uri = Uri.parse(url);
  Response response = await get(uri);
  return response.body;
}
