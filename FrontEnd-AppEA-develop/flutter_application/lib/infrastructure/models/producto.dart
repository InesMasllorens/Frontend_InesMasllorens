import 'dart:convert';

import 'asignacion.dart';

class Producto {
    String id;
    String name;
    int quantity;
    num totalprice;
    List<Asignacion> asignaciones;
    DateTime createdAt;
    DateTime updatedAt;

    Producto({
        required this.id,
        required this.name,
        required this.quantity,
        required this.totalprice,
        required this.asignaciones,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Producto.fromRawJson(String str) => Producto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["_id"],
        name: json["name"],
        quantity: json["quantity"],
        totalprice: json["totalprice"],
        asignaciones: List<Asignacion>.from(json["asignaciones"].map((x) => Asignacion.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "quantity": quantity,
        "totalprice": totalprice,
        "asignaciones": List<dynamic>.from(asignaciones.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
