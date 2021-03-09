import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/Search/SearchModel.dart';
import 'package:test_app/Util/Constant.dart';

import 'SharePrefarence.dart';

Future<List<SerarchListModel>> fetchSearchList(String item) async {
  var token=await getTokenValue();
  print(token);
  http.Response response = await http.get(
      '${Constant.url}/api/search/$item',
      headers:{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = jsonDecode(response.body);
    var responseData=responseJson['data'];
    List<SerarchListModel> searchListData=[];
    for(var item in responseData){
      searchListData.add(SerarchListModel.fromJson(item));
    }

    return searchListData;
    // return (responseJson['data'] as List)
    //     .map((p) => FetchVisitedPlaceModel.fromJson(p))
    //     .toList();
  }
  // else {
  //   // If the server did not return a 201 CREATED response,
  //   // then throw an exception.
  //   throw Exception('Failed to load search data ');
  // }
}