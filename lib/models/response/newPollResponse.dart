// To parse this JSON data, do
//
//     final newPollResponse = newPollResponseFromJson(jsonString);

import 'dart:convert';

import 'package:encuesta_flutter/models/models.dart';

NewPollResponse newPollResponseFromJson(String str) => NewPollResponse.fromJson(json.decode(str));

String newPollResponseToJson(NewPollResponse data) => json.encode(data.toJson());

class NewPollResponse {
    NewPollResponse({
        required this.ok,
        required this.newPoll,
    });

    bool ok;
    Poll newPoll;

    factory NewPollResponse.fromJson(Map<String, dynamic> json) => NewPollResponse(
        ok: json["ok"],
        newPoll: Poll.fromJson(json["newPoll"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "newPoll": newPoll.toJson(),
    };
}
