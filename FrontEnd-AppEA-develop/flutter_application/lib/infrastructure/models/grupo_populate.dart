import 'package:flutter_application/infrastructure/models/ticket.dart';
import 'package:flutter_application/infrastructure/models/user.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class GrupoPopulate {
    String id;
    String name;
    String codigo;
    List<User> users;
    List<Ticket> tickets;
    String descripcion;
    DateTime createdAt;
    DateTime updatedAt;

    GrupoPopulate({
        required this.id,
        required this.name,
        required this.codigo,
        required this.users,
        required this.tickets,
        required this.descripcion,
        required this.createdAt,
        required this.updatedAt,
    });

    factory GrupoPopulate.fromRawJson(String str) => GrupoPopulate.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GrupoPopulate.fromJson(Map<String, dynamic> json) => GrupoPopulate(
        id: json["_id"],
        name: json["name"],
        codigo: json["codigo"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        tickets: List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
        descripcion: json["descripcion"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "codigo": codigo,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
        "descripcion": descripcion,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}