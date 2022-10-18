// To parse this JSON data, do
//
//     final publicPollsResponse = publicPollsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:encuesta_flutter/models/models.dart';

PublicPollsResponse publicPollsResponseFromJson(String str) => PublicPollsResponse.fromJson(json.decode(str));

String publicPollsResponseToJson(PublicPollsResponse data) => json.encode(data.toJson());

class PublicPollsResponse {
    PublicPollsResponse({
        required this.ok,
        required this.polls,
    });

    bool ok;
    List<Poll> polls;

    factory PublicPollsResponse.fromJson(Map<String, dynamic> json) => PublicPollsResponse(
        ok: json["ok"],
        polls: List<Poll>.from(json["polls"].map((x) => Poll.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "polls": List<dynamic>.from(polls.map((x) => x.toJson())),
    };
}