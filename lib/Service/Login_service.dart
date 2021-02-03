import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:test_app/Util/Constant.dart';
Future<Map<String, dynamic>> login(String phoneNumber, String contact) async {
  final http.Response response = await http.post(
    '${Constant.url}/api/login',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: jsonEncode(<String, String>{
      'contact': phoneNumber,
      'pin': contact,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    return json.decode(response.body);
  } else if (response.statusCode == 400) {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return json.decode(response.body);
  }
}
//
// Future<LoginTokenModel> login(Login loginInfo) async {
//   final response = await _login(loginInfo);
//
//   return loginTokenModelFromJson(response.body);
// }