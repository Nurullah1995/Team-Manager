// To parse this JSON data, do
//
//     final serarchListModel = serarchListModelFromJson(jsonString);

import 'dart:convert';

SerarchListModel serarchListModelFromJson(String str) => SerarchListModel.fromJson(json.decode(str));

String serarchListModelToJson(SerarchListModel data) => json.encode(data.toJson());

class SerarchListModel {
  SerarchListModel({
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

  factory SerarchListModel.fromJson(Map<String, dynamic> json) => SerarchListModel(
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
