// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:encuesta_flutter/models/models/user.dart';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
    RegisterResponse({
        required this.ok,
        required this.user,
        required this.token,
    });

    bool ok;
    User user;
    String token;

    factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        ok: json["ok"],
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user.toJson(),
        "token": token,
    };
}

