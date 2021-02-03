// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.contact,
    this.pin,
  });

  String contact;
  String pin;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    contact: json["contact"],
    pin: json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "contact": contact,
    "pin": pin,
  };
}