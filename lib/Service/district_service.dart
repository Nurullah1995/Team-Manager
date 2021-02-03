import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/District/FetchAllDistrictModel.dart';
import 'package:test_app/Util/Constant.dart';



import 'SharePrefarence.dart';

Future<List<FetchAllDistrict>> fetchDistrictList() async {
  var token=await getTokenValue();
  http.Response response = await http.get(
      '${Constant.url}/api/districts',
      headers:{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
   // print(responseJson);
    return (responseJson['districts'] as List)
        .map((p) => FetchAllDistrict.fromJson(p))
        .toList();
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login district');
  }
}