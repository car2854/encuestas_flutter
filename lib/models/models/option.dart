class Option {
    Option({
        required this.amountVote,
        required this.id,
        required this.name,
        required this.newOptionPollId,
        required this.pollId,
    });

    int amountVote;
    int id;
    String name;
    int newOptionPollId;
    int pollId;

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        amountVote: json["amount_vote"],
        id: json["id"],
        name: json["name"],
        newOptionPollId: json["poll_id"],
        pollId: json["pollId"],
    );

    Map<String, dynamic> toJson() => {
        "amount_vote": amountVote,
        "id": id,
        "name": name,
        "poll_id": newOptionPollId,
        "pollId": pollId,
    };
}