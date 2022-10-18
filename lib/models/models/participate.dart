class Participate {
    Participate({
        required this.id,
        required this.participateUserId,
        required this.participatePollId,
        required this.participateOptionId,
        required this.optionId,
        required this.pollId,
        required this.userId,
    });

    int id;
    int participateUserId;
    int participatePollId;
    int participateOptionId;
    int optionId;
    int pollId;
    int userId;

    factory Participate.fromJson(Map<String, dynamic> json) => Participate(
        id: json["id"],
        participateUserId: json["user_id"],
        participatePollId: json["poll_id"],
        participateOptionId: json["option_id"],
        optionId: json["optionId"],
        pollId: json["pollId"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": participateUserId,
        "poll_id": participatePollId,
        "option_id": participateOptionId,
        "optionId": optionId,
        "pollId": pollId,
        "userId": userId,
    };
}
