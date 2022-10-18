import 'package:encuesta_flutter/models/models.dart';

class DetailOption {
    DetailOption({
        required this.id,
        required this.name,
        required this.amountVote,
        required this.detailOptionPollId,
        required this.pollId,
        required this.participates,
    });

    int id;
    String name;
    int amountVote;
    int detailOptionPollId;
    int pollId;
    List<ParticipateOption> participates;

    factory DetailOption.fromJson(Map<String, dynamic> json) => DetailOption(
        id: json["id"],
        name: json["name"],
        amountVote: json["amount_vote"],
        detailOptionPollId: json["poll_id"],
        pollId: json["pollId"],
        participates: List<ParticipateOption>.from(json["participates"].map((x) => ParticipateOption.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount_vote": amountVote,
        "poll_id": detailOptionPollId,
        "pollId": pollId,
        "participates": List<dynamic>.from(participates.map((x) => x.toJson())),
    };
}