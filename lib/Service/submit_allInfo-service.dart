
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_app/Util/Constant.dart';

import 'SharePrefarence.dart';

Future submitAllInfo(String contact, String ownerName, String orgName,String orgType, String newFollow, File img,String lat, String long ,String distict,String thana, String address) async {
  var token=await getTokenValue();
  Map<String, String> headers = {
   //  HttpHeaders.contentTypeHeader: 'application/json',
    "Accept":"application/json",
    "Authorization":"Bearer "+token,
   // HttpHeaders.authorizationHeader: "Bearer"+token,
  };


  var request = http.MultipartRequest('POST', Uri.parse('${Constant.url}/api/visited-places'));
  request.headers.addAll(headers);

  // print("The name is ${category.name}");

  request.fields['contact'] = contact;
  request.fields['ownerName'] = ownerName;
  request.fields['orgName'] = orgName;
  request.fields['orgtype'] = orgType;
  if(newFollow!=null){
    request.fields['nextFollowup'] = newFollow;
  }
 // request.fields['orgImage'] = productinfo.regularPrice;
  request.files.add(
      await http.MultipartFile.fromPath(
        'orgImage',
        img.path,
      )
  );
  request.fields['lat'] = lat;
  request.fields['long'] = long;
  request.fields['district'] = distict;
  request.fields['thana'] = thana;
  request.fields['address'] = address;

  final response = await request.send();
  return response;
}