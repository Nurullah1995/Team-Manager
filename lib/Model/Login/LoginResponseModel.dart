// To parse this JSON data, do
//
//     final loginTokenModel = loginTokenModelFromJson(jsonString);

import 'dart:convert';

LoginTokenModel loginTokenModelFromJson(String str) => LoginTokenModel.fromJson(json.decode(str));

String loginTokenModelToJson(LoginTokenModel data) => json.encode(data.toJson());

class LoginTokenModel {
  LoginTokenModel({
    this.token,
    this.user,
  });

  String token;
  User user;

  factory LoginTokenModel.fromJson(Map<String, dynamic> json) => LoginTokenModel(
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.name,
    this.contact,
    this.role,
    this.image,
  });

  String name;
  String contact;
  String role;
  String image;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    contact: json["contact"],
    role: json["role"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "contact": contact,
    "role": role,
    "image": image,
  };
}
