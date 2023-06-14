import 'package:flutter_application/infrastructure/models/asignacion.dart';
import 'package:flutter_application/infrastructure/models/grupo_populate.dart';
import 'package:flutter_application/infrastructure/models/producto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

import '../infrastructure/models/grupo.dart';
import '../infrastructure/models/ticket.dart';
import '../infrastructure/models/user.dart';

abstract class Constants{
  static String apiUrl = "http://${dotenv.env['IP_DEVICE']}";
  static String token="";
  static User user=User(id: "", name: "name", surname: "surname", email: "email", password: "password", role: "role", isEnabled: true, createdAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"), updatedAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"));
  static Ticket ticket=Ticket(id: "", nombre: "name", productos: <Producto>[], location: "location", anfitrion: "anfitrion", createdAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"), updatedAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"),isEnabled: true,completado: []);
  static GrupoPopulate grupoPopulate=GrupoPopulate(id: "", name: "", codigo: "codigo", users: <User>[], tickets: <Ticket>[] , descripcion: "descripcion", createdAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"), updatedAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"));
  static List<Grupo> listGrupos=<Grupo>[];
  static Ticket ticketPopulate = Ticket(id: "", nombre: "", productos: <Producto>[], location: "descripcion", anfitrion: "descripcion", createdAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"), updatedAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"),isEnabled: true,completado: []);
  static Producto productoPopulate = Producto(id: "", name: "", quantity: 0, totalprice: 0, asignaciones: <Asignacion>[], createdAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"), updatedAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"));

  static Set<Marker>  markers ={};
  static String idTicketSeleccionado="";


  static List<Ticket> listTickets=<Ticket>[];

}

