import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_app/Model/Category/FetchCategoryShopModel.dart';
import 'package:test_app/Util/Constant.dart';


import 'SharePrefarence.dart';

Future<List<FetchShopCategory>> fetchCategoyShopList() async {
  var token=await getTokenValue();
  http.Response response = await http.get(
      '${Constant.url}/api/org-types',
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
    return (responseJson['orgTypes'] as List)
        .map((p) => FetchShopCategory.fromJson(p))
        .toList();
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login Category');
  }
}