import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_app/Util/Constant.dart';


Future<dynamic> addUser(String companyId,String teamId, String userName, String contactPhNo,String pin, String confirmPin) async {
  final http.Response response = await http.post(
    '${Constant.url}/api/signup',
    headers: <String, String>{
      "Accept":"application/json",
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'company': companyId,
      'team': teamId,
      'name': userName,
      'contact': contactPhNo,
      'pin': pin,
      'confirmPin': confirmPin,
    }),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body));
  }
  else if(response.statusCode == 422){
    //print(jsonDecode(response.body));
    return (jsonDecode(response.body));
  }
}