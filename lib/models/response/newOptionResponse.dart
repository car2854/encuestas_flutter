// To parse this JSON data, do
//
//     final newOptionResponse = newOptionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:encuesta_flutter/models/models.dart';

NewOptionResponse newOptionResponseFromJson(String str) => NewOptionResponse.fromJson(json.decode(str));

String newOptionResponseToJson(NewOptionResponse data) => json.encode(data.toJson());

class NewOptionResponse {
    NewOptionResponse({
        required this.ok,
        required this.newOption,
    });

    bool ok;
    Option newOption;

    factory NewOptionResponse.fromJson(Map<String, dynamic> json) => NewOptionResponse(
        ok: json["ok"],
        newOption: Option.fromJson(json["newOption"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "newOption": newOption.toJson(),
    };
}