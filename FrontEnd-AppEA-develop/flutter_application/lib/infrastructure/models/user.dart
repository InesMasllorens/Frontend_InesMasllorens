// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
    String id;
    String name;
    String surname;
    String email;
    String password;
    String role;
    bool isEnabled;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.name,
        required this.surname,
        required this.email,
        required this.password,
        required this.role,
        required this.isEnabled,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        isEnabled: json["isEnabled"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "role": role,
        "isEnabled": isEnabled,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
