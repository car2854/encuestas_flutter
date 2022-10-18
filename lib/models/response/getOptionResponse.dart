// To parse this JSON data, do
//
//     final getOptionsResponse = getOptionsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:encuesta_flutter/models/models/option.dart';

GetOptionsResponse getOptionsResponseFromJson(String str) => GetOptionsResponse.fromJson(json.decode(str));

String getOptionsResponseToJson(GetOptionsResponse data) => json.encode(data.toJson());

class GetOptionsResponse {
    GetOptionsResponse({
        required this.ok,
        required this.options,
    });

    bool ok;
    List<Option> options;

    factory GetOptionsResponse.fromJson(Map<String, dynamic> json) => GetOptionsResponse(
        ok: json["ok"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
    };
}