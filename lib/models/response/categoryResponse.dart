// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:encuesta_flutter/models/models.dart';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
    CategoryResponse({
        required this.ok,
        required this.categories,
    });

    bool ok;
    List<Category> categories;

    factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        ok: json["ok"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}
