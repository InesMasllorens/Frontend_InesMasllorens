import 'package:dio/dio.dart';
import 'package:flutter_application/infrastructure/models/asignacion.dart';
import 'package:flutter_application/infrastructure/models/grupo.dart';
import 'package:flutter_application/infrastructure/models/grupo_populate.dart';
import 'package:flutter_application/infrastructure/models/producto.dart';
import 'package:flutter_application/repositories/grupo_repository.dart';

import '../infrastructure/models/proceso_deuda.dart';
import '../infrastructure/models/deuda.dart';
import '../infrastructure/models/ticket.dart';
import '../infrastructure/models/user.dart';
import '../utils/constants.dart';

class GrupoRepositoryImpl extends GrupoRespository {
  String path = '${Constants.apiUrl}/grupo';

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
  Future<List<Grupo>?> getGrupos() async {
    List<Grupo> grupoList = <Grupo>[];
    try {
      var response = await Dio().get('$path/all',
          options: Options(headers: {'Authorization': Constants.token}));
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }

      var registros = response.data as List;
      for (var sub in registros) {
        grupoList.add(Grupo.fromJson(sub));
      }

      grupoList.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return grupoList;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> crearGrupo(String name, String descripcion) async {
    var response = await Dio().post("$path/post/", data: {
      "name": name,
      "users": Constants.user.id,
      "descripcion": descripcion
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> exitGrupo(String idGrupo) async {
    var response = await Dio().post("$path/exit",
        data: {"idUser": Constants.user.id, "idGrupo": idGrupo});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> joinGrupo(String codigoGrupo) async {
    var response = await Dio().post("$path/join", data: {
      "idUser": Constants.user.id,
      "codigo": codigoGrupo,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  tablaDeudas() {
    GrupoPopulate grupoPopulate = Constants.grupoPopulate;

    List<ProcesoDeuda> listProcesoTablaDeudas = [];
    for (User user in grupoPopulate.users) {
      String idUser = user.id;
      num haPagado = 0;
      num deuda = 0;

      for (Ticket ticket in grupoPopulate.tickets) {
        for (Producto producto in ticket.productos) {
          num cantidadTotal = 0;
          num cantidadIndividual = 0;
          if (idUser == ticket.anfitrion) {
            haPagado = haPagado + producto.totalprice;
          }
          for (Asignacion asignacion in producto.asignaciones) {
            cantidadTotal = cantidadTotal + asignacion.cantidad;
            if (idUser == asignacion.usuario) {
              cantidadIndividual = asignacion.cantidad;
            }
          }
          if (cantidadTotal == 0) {
            cantidadTotal = 1;
          }
          deuda =
              deuda + producto.totalprice * cantidadIndividual / cantidadTotal;
        }
      }
      ProcesoDeuda procesoTablaDeudas = ProcesoDeuda(idUser, haPagado - deuda);
      listProcesoTablaDeudas.add(procesoTablaDeudas);
    }

    listProcesoTablaDeudas.sort((a, b) => a.deuda >= b.deuda ? 0 : 1);

    int i = 0;
    int y = grupoPopulate.users.length - 1;
    int bucleAcabado = listProcesoTablaDeudas.length;

    List<Deuda> listTablaDeudas = [];

    while (bucleAcabado > 0) {
      if (listProcesoTablaDeudas[i].idUser !=
          listProcesoTablaDeudas[y].idUser) {
        num diferencia =
            listProcesoTablaDeudas[i].deuda + listProcesoTablaDeudas[y].deuda;
        Deuda tablaDeudas;
        if (diferencia > 0) {
          listProcesoTablaDeudas[i].deuda = diferencia;
          tablaDeudas = Deuda(
              grupoPopulate.users.firstWhere(
                  (user) => user.id == listProcesoTablaDeudas[i].idUser),
              grupoPopulate.users.firstWhere(
                  (user) => user.id == listProcesoTablaDeudas[y].idUser),
              listProcesoTablaDeudas[y].deuda.abs());
          y--;
          bucleAcabado--;
        } else if (diferencia < 0) {
          listProcesoTablaDeudas[y].deuda = diferencia;
          tablaDeudas = Deuda(
              grupoPopulate.users.firstWhere(
                  (user) => user.id == listProcesoTablaDeudas[i].idUser),
              grupoPopulate.users.firstWhere(
                  (user) => user.id == listProcesoTablaDeudas[y].idUser),
              listProcesoTablaDeudas[i].deuda.abs());
          i++;
          bucleAcabado--;
        } else {
          tablaDeudas = Deuda(
              grupoPopulate.users.firstWhere(
                  (user) => user.id == listProcesoTablaDeudas[i].idUser),
              grupoPopulate.users.firstWhere(
                  (user) => user.id == listProcesoTablaDeudas[y].idUser),
              listProcesoTablaDeudas[y].deuda.abs());

          y--;
          i++;
          bucleAcabado--;
          bucleAcabado--;
        }
        if (tablaDeudas.deuda != 0) {
          listTablaDeudas.add(tablaDeudas);
        }
      } else {
        bucleAcabado--;
      }
    }
    return listTablaDeudas;
  }

  @override
  Future<bool> existeCodigo(String codigo) async {
    try {
      var response = await Dio().get('$path/code/all',
          queryParameters: {'codigo': codigo},
          options: Options(headers: {'Authorization': Constants.token}));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false; // Si ocurre algún error, se asume que el código no existe
    }
  }
}
