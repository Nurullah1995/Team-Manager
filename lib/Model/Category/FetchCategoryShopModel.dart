// To parse this JSON data, do
//
//     final fetchShopCategory = fetchShopCategoryFromJson(jsonString);

import 'dart:convert';

List<FetchShopCategory> fetchShopCategoryFromJson(String str) => List<FetchShopCategory>.from(json.decode(str).map((x) => FetchShopCategory.fromJson(x)));

String fetchShopCategoryToJson(List<FetchShopCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchShopCategory {
  FetchShopCategory({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory FetchShopCategory.fromJson(Map<String, dynamic> json) => FetchShopCategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
