import 'package:http/http.dart' as http;
import 'dart:convert';

import 'SharePrefarence.dart';


Future<dynamic> createOTp(String otpNumber) async {
  var headers = {
    'Accept': 'application/json'
  };
  var request = http.Request('GET', Uri.parse('https://smanagerit.xyz/crm/api/otp/create?contact=${otpNumber}'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}