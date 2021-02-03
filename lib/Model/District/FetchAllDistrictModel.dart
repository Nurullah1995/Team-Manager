// To parse this JSON data, do
//
//     final fetchAllDistrict = fetchAllDistrictFromJson(jsonString);

import 'dart:convert';

List<FetchAllDistrict> fetchAllDistrictFromJson(String str) => List<FetchAllDistrict>.from(json.decode(str).map((x) => FetchAllDistrict.fromJson(x)));

String fetchAllDistrictToJson(List<FetchAllDistrict> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchAllDistrict {
  FetchAllDistrict({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory FetchAllDistrict.fromJson(Map<String, dynamic> json) => FetchAllDistrict(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
