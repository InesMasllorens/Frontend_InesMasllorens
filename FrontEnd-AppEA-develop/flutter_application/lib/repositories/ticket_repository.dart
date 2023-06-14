
import 'package:flutter_application/infrastructure/models/ticket.dart';



import '../infrastructure/models/grupo_populate.dart';

abstract class TicketRespository{


  Future<Ticket> getPopulateTicket(String idTicket);
  Future<bool> productoToTicket(String idTicket, String idProducto);

  Future<GrupoPopulate> getPopulateGrupo(String idGrupo);
  Future <bool> exitTicket(String idTicket);
  Future<bool> crearTicket(String name, String localization);
  Future<bool> putCompletadosToTicket();

}