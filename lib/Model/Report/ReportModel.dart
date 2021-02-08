// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

List<ReportModel> reportModelFromJson(String str) => List<ReportModel>.from(json.decode(str).map((x) => ReportModel.fromJson(x)));

String reportModelToJson(List<ReportModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportModel {
  ReportModel({
    this.visitToday,
    this.visitThisWeek,
    this.visitThisMonth,
    this.visitThisYear,
    this.followupToday,
    this.followupThisWeek,
    this.followupThisMonth,
    this.followupThisYear,
  });

  int visitToday;
  int visitThisWeek;
  int visitThisMonth;
  int visitThisYear;
  int followupToday;
  int followupThisWeek;
  int followupThisMonth;
  int followupThisYear;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    visitToday: json["visitToday"],
    visitThisWeek: json["visitThisWeek"],
    visitThisMonth: json["visitThisMonth"],
    visitThisYear: json["visitThisYear"],
    followupToday: json["followupToday"],
    followupThisWeek: json["followupThisWeek"],
    followupThisMonth: json["followupThisMonth"],
    followupThisYear: json["followupThisYear"],
  );

  Map<String, dynamic> toJson() => {
    "visitToday": visitToday,
    "visitThisWeek": visitThisWeek,
    "visitThisMonth": visitThisMonth,
    "visitThisYear": visitThisYear,
    "followupToday": followupToday,
    "followupThisWeek": followupThisWeek,
    "followupThisMonth": followupThisMonth,
    "followupThisYear": followupThisYear,
  };
}
