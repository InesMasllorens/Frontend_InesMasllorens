
// To parse this JSON data, do
//
//     final grupo = grupoFromJson(jsonString);

import 'dart:convert';

List<Grupo> grupoFromJson(String str) => List<Grupo>.from(json.decode(str).map((x) => Grupo.fromJson(x)));

String grupoToJson(List<Grupo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Grupo {
    String id;
    String name;

    String codigo;

    List<String> users;
    List<String> tickets;
    String descripcion;
    DateTime createdAt;
    DateTime updatedAt;

    Grupo({
        required this.id,
        required this.name,
        required this.codigo,

        required this.users,
        required this.tickets,
        required this.descripcion,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        id: json["_id"],
        name: json["name"],
        codigo: json["codigo"],

 

        users: List<String>.from(json["users"].map((x) => x)),
        tickets: List<String>.from(json["tickets"].map((x) => x)),
        descripcion: json["descripcion"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "codigo": codigo,

        "users": List<dynamic>.from(users.map((x) => x)),
        "tickets": List<dynamic>.from(tickets.map((x) => x)),
        "descripcion": descripcion,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };

}

