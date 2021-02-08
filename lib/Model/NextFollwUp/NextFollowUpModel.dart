// To parse this JSON data, do
//
//     final nextFollowUpModel = nextFollowUpModelFromJson(jsonString);

import 'dart:convert';

List<NextFollowUpModel> nextFollowUpModelFromJson(String str) => List<NextFollowUpModel>.from(json.decode(str).map((x) => NextFollowUpModel.fromJson(x)));

String nextFollowUpModelToJson(List<NextFollowUpModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NextFollowUpModel {
  NextFollowUpModel({
    this.followupDate,
    this.total,
    this.followUpId,
    this.visitedPlaceId,
    this.orgName,
    this.orgOwner,
    this.orgContact,
    this.upazila,
    this.district,
    this.visitedDateTime,
  });

  DateTime followupDate;
  int total;
  int followUpId;
  int visitedPlaceId;
  String orgName;
  String orgOwner;
  String orgContact;
  String upazila;
  String district;
  String visitedDateTime;

  factory NextFollowUpModel.fromJson(Map<String, dynamic> json) => NextFollowUpModel(
    followupDate: DateTime.parse(json["followup_date"]),
    total: json["total"],
    followUpId: json["followUpId"],
    visitedPlaceId: json["visitedPlaceId"],
    orgName: json["org_name"],
    orgOwner: json["org_owner"],
    orgContact: json["org_contact"],
    upazila: json["upazila"],
    district: json["district"],
    visitedDateTime: json["visitedDateTime"],
  );

  Map<String, dynamic> toJson() => {
    "followup_date": "${followupDate.year.toString().padLeft(4, '0')}-${followupDate.month.toString().padLeft(2, '0')}-${followupDate.day.toString().padLeft(2, '0')}",
    "total": total,
    "followUpId": followUpId,
    "visitedPlaceId": visitedPlaceId,
    "org_name": orgName,
    "org_owner": orgOwner,
    "org_contact": orgContact,
    "upazila": upazila,
    "district": district,
    "visitedDateTime": visitedDateTime,
  };
}
