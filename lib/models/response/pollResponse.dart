// To parse this JSON data, do
//
//     final pollResponse = pollResponseFromJson(jsonString);

import 'dart:convert';

import 'package:encuesta_flutter/models/models/poll.dart';


PollResponse pollResponseFromJson(String str) => PollResponse.fromJson(json.decode(str));

String pollResponseToJson(PollResponse data) => json.encode(data.toJson());

class PollResponse {
    PollResponse({
        required this.ok,
        required this.polls,
    });

    bool ok;
    List<Poll> polls;

    factory PollResponse.fromJson(Map<String, dynamic> json) => PollResponse(
        ok: json["ok"],
        polls: List<Poll>.from(json["polls"].map((x) => Poll.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "polls": List<dynamic>.from(polls.map((x) => x.toJson())),
    };
}