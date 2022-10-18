class User {
    User({
        required this.createdAt,
        required this.status,
        required this.id,
        required this.email,
        required this.password,
        required this.name,
    });

    DateTime createdAt;
    bool status;
    int id;
    String email;
    String password;
    String name;

    factory User.fromJson(Map<String, dynamic> json) => User(
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "id": id,
        "email": email,
        "password": password,
        "name": name,
    };
}