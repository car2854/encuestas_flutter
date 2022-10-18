// To parse this JSON data, do
//
//     final getDetailOptionResponse = getDetailOptionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:encuesta_flutter/models/models/detailOption.dart';

GetDetailOptionResponse getDetailOptionResponseFromJson(String str) => GetDetailOptionResponse.fromJson(json.decode(str));

String getDetailOptionResponseToJson(GetDetailOptionResponse data) => json.encode(data.toJson());

class GetDetailOptionResponse {
    GetDetailOptionResponse({
        required this.ok,
        required this.detailOption,
    });

    bool ok;
    DetailOption detailOption;

    factory GetDetailOptionResponse.fromJson(Map<String, dynamic> json) => GetDetailOptionResponse(
        ok: json["ok"],
        detailOption: DetailOption.fromJson(json["detailOption"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "detailOption": detailOption.toJson(),
    };
}
