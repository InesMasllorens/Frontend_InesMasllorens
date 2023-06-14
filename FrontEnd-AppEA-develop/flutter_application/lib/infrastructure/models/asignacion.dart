import 'dart:convert';

class Asignacion {
    String id;
    String usuario;
    int cantidad;
    DateTime createdAt;
    DateTime updatedAt;

    Asignacion({
        required this.id,
        required this.usuario,
        required this.cantidad,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Asignacion.fromRawJson(String str) => Asignacion.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Asignacion.fromJson(Map<String, dynamic> json) => Asignacion(
        id: json["_id"],
        usuario: json["usuario"],
        cantidad: json["cantidad"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "usuario": usuario,
        "cantidad": cantidad,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
