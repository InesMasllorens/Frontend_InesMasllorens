import 'package:dio/dio.dart';
import 'package:flutter_application/infrastructure/models/completado.dart';
import 'package:flutter_application/infrastructure/models/grupo.dart';
import 'package:flutter_application/infrastructure/models/grupo_populate.dart';

import 'package:flutter_application/repositories/ticket_repository.dart';

import '../infrastructure/models/ticket.dart';
import '../utils/constants.dart';

class TicketRepositoryImpl extends TicketRespository {
  String path = '${Constants.apiUrl}/grupo';
  String pathTicket = '${Constants.apiUrl}/ticket';

  @override
  Future<Ticket> getPopulateTicket(String idTicket) async {
    var response1 = await Dio().get('$pathTicket/get/$idTicket',
        options: Options(headers: {'Authorization': Constants.token}));
    if (response1.statusCode != 200) {
      throw Exception(response1.statusMessage);
    }

    Constants.ticketPopulate = Ticket.fromJson(response1.data);
    return Ticket.fromJson(response1.data);
  }

  @override
  Future<GrupoPopulate> getPopulateGrupo(String idGrupo) async {
    var response = await Dio().get('$path/populate/$idGrupo',
        options: Options(headers: {'Authorization': Constants.token}));
    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }

    Constants.grupoPopulate = GrupoPopulate.fromJson(response.data);
    return GrupoPopulate.fromJson(response.data);
  }

  @override
  Future<bool> productoToTicket(String idTicket, String idProducto) async {
    var response1 = await Dio().post('$pathTicket/insert',
        data: {"idTicket": idTicket, "idProducto": idProducto});
    if (response1.statusCode == 200) {
      return true;
    } else {
      return false;
    }

    //Constants.grupoPopulate = GrupoPopulate.fromJson(response1.data);
    //return GrupoPopulate.fromJson(response1.data);
  }

  @override
  Future<bool> exitTicket(String idTicket) async {
    var response = await Dio().delete("$pathTicket/delete/$idTicket",
        data: {"idGrupo": Constants.grupoPopulate.id, "idTicket": idTicket});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> crearTicket(String name, String localization) async {
    var response = await Dio().post("$pathTicket/post", data: {
      "nombre": name,
      "location": localization,
      "userId": Constants.user.id,
      "grupoId": Constants.grupoPopulate.id,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> putCompletadosToTicket() async {
    var response = await Dio().put('$pathTicket/t/completado', data: {
      "idUsuario": Constants.user.id,
      "completados": getListCompltadosOfGrupo(),
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  List<dynamic> getListCompltadosOfGrupo() {
    List<dynamic> listCompltadosOfGrupo = [];
    GrupoPopulate grupoPopulate = Constants.grupoPopulate;
    for (Ticket ticket in grupoPopulate.tickets) {
      Completado completado = ticket.completado
          .firstWhere((completado) => completado.usuario == Constants.user.id);
      listCompltadosOfGrupo.add({
        "idTicket": ticket.id,
        "completado": completado.completado,
      });
    }
    return listCompltadosOfGrupo;
  }
}
