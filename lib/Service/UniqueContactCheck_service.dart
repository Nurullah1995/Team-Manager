import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/Util/Constant.dart';
import 'SharePrefarence.dart';

Map<String,dynamic> foundDataList = Map<String,dynamic>();

Future<Map<String,dynamic>> fetchFoundDataList(String id) async {
  var token=await getTokenValue();
  var res = await http.get(
      Uri.encodeFull("${Constant.url}/api/check-visited-place?contact=$id"),
      headers:{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }
  );
  if (res.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(res.body);
    print(responseJson);
    return (responseJson['data']);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login Category');
  }
}