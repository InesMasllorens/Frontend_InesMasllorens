import 'package:flutter_application/infrastructure/models/producto.dart';


abstract class ProductoRespository{

  Future<bool> insertProducto(String name, String quantity, String totalprice);
  Future<bool> insertProductotoTicket(String name, String quantity, String totalprice, String idTicket,);
  Future<bool> putAsignacionToProducto(String idUser, List<dynamic> productosAsignados);
  Future<Producto> getPopulateProducto(String name, String quantity, String totalprice);
}