import 'package:http/http.dart' as http;
import 'package:test_app/Util/Constant.dart';
import 'dart:convert';

import 'SharePrefarence.dart';


Future<dynamic> checkOTP(String otpNumber,String otp) async {
  var token=await getTokenValue();
  http.Response response = await http.get(
      '${Constant.url}/api/otp-check?contact=$otpNumber&otp=${otp}',
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
    return responseJson;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load check OTP');
  }
}