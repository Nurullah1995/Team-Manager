import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Util/Constant.dart';
import 'SharePrefarence.dart';

Future nextFollowUpUpdate(String nextFollowUpId, String visitedPaceId)async{
  var token=await getTokenValue();
  var headers = {
    'Accept': 'application/json',
    "Authorization":"Bearer "+token,
  };
  var request = http.MultipartRequest('POST', Uri.parse('${Constant.url}/api/follow-up/update'));
  request.fields.addAll({
    'followUpId': nextFollowUpId.toString(),
    'visitedPlaceId': visitedPaceId.toString(),
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
  print(response.reasonPhrase);
  }
}