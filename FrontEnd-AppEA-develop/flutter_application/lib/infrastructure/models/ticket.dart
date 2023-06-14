import 'dart:convert';

import 'package:flutter_application/infrastructure/models/producto.dart';

import 'completado.dart';

class Ticket {
    String id;
    String nombre;
    bool isEnabled;
    List<Producto> productos;
    String location;
    String anfitrion;
    DateTime createdAt;
    DateTime updatedAt;
    List<Completado> completado;

    Ticket({
        required this.id,
        required this.nombre,
        required this.isEnabled,
        required this.productos,
        required this.location,
        required this.anfitrion,
        required this.createdAt,
        required this.updatedAt,
        required this.completado,
    });

    factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["_id"],
        nombre: json["nombre"],
        isEnabled: json["isEnabled"],
        productos: List<Producto>.from(json["productos"].map((x) => Producto.fromJson(x))),
        location: json["location"],
        anfitrion: json["anfitrion"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        completado: List<Completado>.from(json["completado"].map((x) => Completado.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "isEnabled": isEnabled,
        "productos": List<dynamic>.from(productos.map((x) => x.toJson())),
        "location": location,
        "anfitrion": anfitrion,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "completado": List<dynamic>.from(completado.map((x) => x)),
    };
}




