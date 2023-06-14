import 'package:dio/dio.dart';
import 'package:flutter_application/infrastructure/models/producto.dart';
import 'package:flutter_application/repositories/producto_repository.dart';

import '../utils/constants.dart';

class ProductoRepositoryImpl extends ProductoRespository {
  String path = '${Constants.apiUrl}/producto';

  @override
  Future<bool> insertProducto(
      String name, String quantity, String totalprice) async {
    var response = await Dio().post('$path/post', data: {
      "name": name,
      "quantity": int.parse(quantity),
      "totalprice": num.parse(totalprice),
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> insertProductotoTicket(
    String name,
    String quantity,
    String totalprice,
    String idTicket,
  ) async {
    print(int.parse(quantity));
    print(num.parse(totalprice));
    print(num.parse(totalprice) / 5);
    var response =
        await Dio().put('$path/put/$idTicket/addProdcutoTicket', data: {
      "name": name,
      "quantity": int.parse(quantity),
      "totalprice": num.parse(totalprice),
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> putAsignacionToProducto(
      String idUser, List<dynamic> productosAsignados) async {
    var response = await Dio().put('$path/p/asignaciones', data: {
      "idUsuario": idUser,
      "productos": productosAsignados,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Producto> getPopulateProducto(
      String name, String quantity, String totalprice) async {
    var response = await Dio().post('$path/busqueda',
        data: {
          "name": name,
          "quantity": quantity,
          "totalprice": totalprice,
        },
        options: Options(headers: {'Authorization': Constants.token}));
    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
    Constants.productoPopulate = Producto.fromJson(response.data);
    return Producto.fromJson(response.data);
  }
}
