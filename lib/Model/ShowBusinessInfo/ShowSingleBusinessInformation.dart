// To parse this JSON data, do
//
//     final showSingleBusinessShop = showSingleBusinessShopFromJson(jsonString);

import 'dart:convert';

ShowSingleBusinessShop showSingleBusinessShopFromJson(String str) => ShowSingleBusinessShop.fromJson(json.decode(str));

String showSingleBusinessShopToJson(ShowSingleBusinessShop data) => json.encode(data.toJson());

class ShowSingleBusinessShop {
  ShowSingleBusinessShop({
    this.visitedPlace,
  });

  VisitedPlace visitedPlace;

  factory ShowSingleBusinessShop.fromJson(Map<String, dynamic> json) => ShowSingleBusinessShop(
    visitedPlace: VisitedPlace.fromJson(json["visitedPlace"]),
  );

  Map<String, dynamic> toJson() => {
    "visitedPlace": visitedPlace.toJson(),
  };
}

class VisitedPlace {
  VisitedPlace({
    this.orgName,
    this.orgTypeName,
    this.ownerName,
    this.visitTime,
    this.contact,
    this.thana,
    this.district,
    this.address,
    this.nextFollowup,
    this.orgImg,
  });

  String orgName;
  String orgTypeName;
  String ownerName;
  String visitTime;
  String contact;
  String thana;
  String district;
  String address;
  String nextFollowup;
  String orgImg;

  factory VisitedPlace.fromJson(Map<String, dynamic> json) => VisitedPlace(
    orgName: json["orgName"],
    orgTypeName: json["orgTypeName"],
    ownerName: json["ownerName"],
    visitTime: json["visitTime"],
    contact: json["contact"],
    thana: json["thana"],
    district: json["district"],
    address: json["address"],
    nextFollowup: json["nextFollowup"],
    orgImg: json["orgImg"],
  );

  Map<String, dynamic> toJson() => {
    "orgName": orgName,
    "orgTypeName": orgTypeName,
    "ownerName": ownerName,
    "visitTime": visitTime,
    "contact": contact,
    "thana": thana,
    "district": district,
    "address": address,
    "nextFollowup": nextFollowup,
    "orgImg": orgImg,
  };
}
