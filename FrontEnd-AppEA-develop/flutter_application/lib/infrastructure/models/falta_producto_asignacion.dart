import 'package:flutter_application/infrastructure/models/producto.dart';
import 'package:flutter_application/infrastructure/models/ticket.dart';

class FaltaProductoAsignacion{
  final Ticket ticket;
  final Producto producto;

  FaltaProductoAsignacion(this.ticket, this.producto);
}