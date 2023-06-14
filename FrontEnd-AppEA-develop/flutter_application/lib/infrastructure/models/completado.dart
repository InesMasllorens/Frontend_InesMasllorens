// To parse this JSON data, do
//
//     final completado = completadoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Completado {
    String id;
    String usuario;
    bool completado;
    DateTime createdAt;
    DateTime updatedAt;

    Completado({
        required this.id,
        required this.usuario,
        required this.completado,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Completado.fromRawJson(String str) => Completado.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Completado.fromJson(Map<String, dynamic> json) => Completado(
        id: json["_id"],
        usuario: json["usuario"],
        completado: json["completado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "usuario": usuario,
        "completado": completado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
