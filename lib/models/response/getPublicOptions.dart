// To parse this JSON data, do
//
//     final getPublicOptionsResponse = getPublicOptionsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:encuesta_flutter/models/models/option.dart';
import 'package:encuesta_flutter/models/models/participate.dart';

GetPublicOptionsResponse getPublicOptionsResponseFromJson(String str) => GetPublicOptionsResponse.fromJson(json.decode(str));

String getPublicOptionsResponseToJson(GetPublicOptionsResponse data) => json.encode(data.toJson());

class GetPublicOptionsResponse {
    GetPublicOptionsResponse({
        required this.ok,
        required this.options,
        this.participate,
    });

    bool ok;
    List<Option> options;
    Participate? participate;

    factory GetPublicOptionsResponse.fromJson(Map<String, dynamic> json) => GetPublicOptionsResponse(
        ok: json["ok"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        participate: (json['participate'] != null)? Participate.fromJson(json["participate"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "participate": participate?.toJson(),
    };
}

