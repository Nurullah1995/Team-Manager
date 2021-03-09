import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/VisitPlace/FetchVisitedPlaceModel.dart';
import 'package:test_app/Util/Constant.dart';

import 'SharePrefarence.dart';


Future<List<FetchVisitedPlaceModel>> fetchVisitShopList() async {
  var token=await getTokenValue();
  print(token);
  http.Response response = await http.get(
      //'${Constant.url}/api/visited-places?page=1',
      '${Constant.url}/api/visited-places',
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
    List<FetchVisitedPlaceModel> visitilistData=[];
    for(var item in responseData){
      visitilistData.add(FetchVisitedPlaceModel.fromJson(item));
    }
     return visitilistData;
    // return (responseJson['data'] as List)
    //     .map((p) => FetchVisitedPlaceModel.fromJson(p))
    //     .toList();
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login authentication');
  }
}


Future<List<FetchVisitedPlaceModel>> fetchVisitShopListNextPage(String nexpageUrl) async {
  var token=await getTokenValue();
  print(token);
  http.Response response = await http.get(
    //'${Constant.url}/api/visited-places?page=1',
      nexpageUrl,
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
    List<FetchVisitedPlaceModel> visitNextlistData=[];
    for(var item in responseData){
      visitNextlistData.add(FetchVisitedPlaceModel.fromJson(item));
    }
    return visitNextlistData;
    // return (responseJson['data'] as List)
    //     .map((p) => FetchVisitedPlaceModel.fromJson(p))
    //     .toList();
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login authentication');
  }
}


Future<dynamic> nextPageUrl()async{
  var token=await getTokenValue();
  print(token);
  http.Response response = await http.get(
      '${Constant.url}/api/visited-places',
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
    var responseData=responseJson['next_page_url'];

    return (responseData);
    // return (responseJson['data'] as List)
    //     .map((p) => FetchVisitedPlaceModel.fromJson(p))
    //     .toList();
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login authentication');
  }


}