import 'package:http/http.dart' as http;
import 'package:test_app/Util/Constant.dart';
import 'dart:convert';
import 'SharePrefarence.dart';


Future<Map<String,dynamic>> resetPin(String pinNumber,String confirmPin, String contact) async {
  final http.Response response = await http.post(
    '${Constant.url}/api/reset-pin',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'pin': pinNumber,
      'confirmPin': confirmPin,
      'contact': contact,
    }),
  );
   print(response.body);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Album loading failed!');
  }
}