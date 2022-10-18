import 'package:encuesta_flutter/models/models/category.dart';
import 'package:encuesta_flutter/models/models/participate.dart';
import 'package:encuesta_flutter/models/models/user.dart';

class Poll {

    Poll({
        required this.id,
        required this.description,
        required this.createdAt,
        required this.initPoll,
        required this.endPoll,
        required this.status,
        required this.isActive,
        required this.pollUserId,
        required this.pollCategoryId,
        required this.userId,
        required this.categoryId,
        required this.category,
        required this.user,
        required this.participates,
    });

    int id;
    String description;
    DateTime createdAt;
    DateTime initPoll;
    DateTime endPoll;
    bool status;
    bool isActive;
    int pollUserId;
    int pollCategoryId;
    int userId;
    int categoryId;
    Category category;
    User user;
    List<Participate>? participates;

    factory Poll.fromJson(Map<String, dynamic> json) => Poll(
        id: json["id"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        initPoll: DateTime.parse(json["init_poll"]),
        endPoll: DateTime.parse(json["end_poll"]),
        status: json["status"],
        isActive: json["is_active"],
        pollUserId: json["user_id"],
        pollCategoryId: json["category_id"],
        userId: json["userId"],
        categoryId: json["categoryId"],
        category: Category.fromJson(json["category"]),
        user: User.fromJson(json["user"]),
        participates: (json["participates"] != null)? List<Participate>.from(json["participates"].map((x) => Participate.fromJson(x))) : null
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "init_poll": initPoll.toIso8601String(),
        "end_poll": endPoll.toIso8601String(),
        "status": status,
        "is_active": isActive,
        "user_id": pollUserId,
        "category_id": pollCategoryId,
        "userId": userId,
        "categoryId": categoryId,
        "category": category.toJson(),
        "user": user.toJson(),
        "participates": List<dynamic>.from(participates!.map((x) => x.toJson())),
    };
}
