// To parse this JSON data, do
//
//     final fetchVisitedPlaceModel = fetchVisitedPlaceModelFromJson(jsonString);

import 'dart:convert';

List<FetchVisitedPlaceModel> fetchVisitedPlaceModelFromJson(String str) => List<FetchVisitedPlaceModel>.from(json.decode(str).map((x) => FetchVisitedPlaceModel.fromJson(x)));

String fetchVisitedPlaceModelToJson(List<FetchVisitedPlaceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchVisitedPlaceModel {
  FetchVisitedPlaceModel({
    this.id,
    this.orgName,
    this.orgContact,
    this.orgOwner,
    this.district,
    this.thana,
    this.visitedDateTime,
  });

  String id;
  String orgName;
  String orgContact;
  String orgOwner;
  String district;
  String thana;
  String visitedDateTime;

  factory FetchVisitedPlaceModel.fromJson(Map<String, dynamic> json) => FetchVisitedPlaceModel(
    id: json["id"],
    orgName: json["org_name"],
    orgContact: json["org_contact"],
    orgOwner: json["org_owner"],
    district: json["district"],
    thana: json["thana"],
    visitedDateTime: json["visitedDateTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "org_name": orgName,
    "org_contact": orgContact,
    "org_owner": orgOwner,
    "district": district,
    "thana": thana,
    "visitedDateTime": visitedDateTime,
  };
}
