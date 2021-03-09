
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_app/Util/Constant.dart';



import 'SharePrefarence.dart';

Future updateSingleBusinessItem(int eiditId,String contact, String ownerName, String orgName,String orgType, String newFollow,
    File img,
    String distict,String thana, String address,String feedback) async {

  var token=await getTokenValue();
  Map<String, String> headers = {
    "Accept":"application/json",
    "Authorization":"Bearer "+token,
  };


  var request = http.MultipartRequest('POST', Uri.parse('${Constant.url}/api/visited-places/${eiditId}/update'));
  request.headers.addAll(headers);

  request.fields['contact'] = contact;
  request.fields['ownerName'] = ownerName;
  request.fields['orgName'] = orgName;
  request.fields['orgtype'] = orgType;

  if(newFollow!=null){
    request.fields['nextFollowup'] = newFollow;
  }
  if(img!=null){
    request.files.add(await http.MultipartFile.fromPath('orgImage', img.path));
  }
  request.fields['district'] = distict;
  request.fields['thana'] = thana;
  request.fields['address'] = address;
  if(feedback!=null){
    request.fields['feedback'] = feedback;
  }
  final response = await request.send();
  return response;
}


//Future<Map<String, dynamic>> updateprofile(
//    UpdateProfileInfo updateProfileInfo, imageFile, signatureFile) async {
//  // var imageStream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
//  // var imageLength = await imageFile.length();
//  // var signatureStream =
//  //     http.ByteStream(Stream.castFrom(signatureFile.openRead()));
//  // var signatureLength = await signatureFile.length();
//
//  String url = "$baseAPIUrl/update-profile-info";
//  String _token = await SavedData().loadToken();
//  String authorization = "Bearer $_token";
//
//  final headers = {
//    'Content-Type': 'application/json',
//    'Accept': 'application/json',
//    "Authorization": authorization
//  };
//
//  var request = http.MultipartRequest("POST", Uri.parse(url));
//  request.headers.addAll(headers);
//  request.fields.addAll(updateProfileInfo.toJson());
//  if (imageFile != null) {
//    request.files
//        .add(await http.MultipartFile.fromPath('image', imageFile.path));
//  }
//  if (signatureFile != null) {
//    request.files.add(
//        await http.MultipartFile.fromPath('signature', signatureFile.path));
//  }
//
//  print(" Update Profile Json ${updateProfileInfo.toJson()}");
//  print("Request Fields ${request.fields}");
//  http.StreamedResponse response = await request.send();
//
//  String respStr = await response.stream.bytesToString();
//  dynamic respJson;
//
//  try {
//    respJson = jsonDecode(respStr);
//  } on FormatException catch (e) {
//    print(e.toString());
//  }
//
//  print('API ${response.statusCode}\n  $respJson');
//
//  bool isSuccess = response.statusCode == 200;
//  var data = json.decode(respStr);
//
//  return {
//    'isSuccess': isSuccess,
//    "message": isSuccess ? data["success"]["message"] : null,
//    "name": isSuccess ? data["success"]["name"] : null,
//    "classgroup": isSuccess ? data["success"]["classgroup"] : null,
//    "image": isSuccess ? data["success"]["image"] : null,
//    "error": isSuccess ? null : data['error']['message'],
//  };
//}