import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/models/asignacion.dart';
import 'package:flutter_application/infrastructure/models/deuda.dart';
import 'package:flutter_application/infrastructure/models/falta_producto_asignacion.dart';
import 'package:flutter_application/infrastructure/models/grupo_populate.dart';
import 'package:flutter_application/infrastructure/models/producto.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';
import 'package:get/get.dart';

import '../../infrastructure/models/completado.dart';
import '../../infrastructure/models/ticket.dart';
import '../../repositories/grupo_repository_impl.dart';
import '../../utils/constants.dart';
import 'info_grupo.dart';

class ListDeudas extends StatelessWidget {
  List<Deuda> listDeudas = GrupoRepositoryImpl().tablaDeudas();
  ListDeudas(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoGrupo(context),
              const Divider(
                height: 10.0,
              ),
              isUsuariosCompletados() ? _textBueno() : _textMalo(),
              Divider(
                height: 25,
              ),
              Text('deudas'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  )),
              DataTable(
                columns:  [
                  DataColumn(
                    label: Text('endeudado'.tr),
                  ),
                  DataColumn(
                    label: Text(''),
                  ),
                  DataColumn(
                    label: Text('beneficiario'.tr),
                  ),
                  DataColumn(
                    label: Text('cantidad_mayus'.tr),
                  ),
                ],
                rows: listDeudas
                    .map(
                      (deuda) => DataRow(cells: [
                        DataCell(
                          Text(
                              "${deuda.userEndeudado.name} ${deuda.userEndeudado.surname}"),
                          // Add tap in the row and populate the
                          // textfields with the corresponding values to update
                          //onTap: () {},
                        ),
                        const DataCell(Icon(Icons.arrow_forward)),
                        DataCell(
                          Text(
                            "${deuda.userBeneficiario.name} ${deuda.userBeneficiario.surname}",
                          ),
                        ),
                        DataCell(
                          Text(
                            "${deuda.deuda.toStringAsFixed(2)} €",
                          ),
                        ),
                      ]),
                    )
                    .toList(),
              ),
              Divider(
                height: 25,
              ),
              Text('productos_noAsignados'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  )),
              DataTable(
                columns: [
                  DataColumn(
                    label: Text('TICKET'),
                  ),
                  DataColumn(
                    label: Text('producto_mayus'.tr),
                  ),
                ],
                rows: faltaProductoAsignacion()
                    .map(
                      (faltaProductoAsignacion) => DataRow(cells: [
                        DataCell(
                          Text(faltaProductoAsignacion.ticket.nombre),
                          // Add tap in the row and populate the
                          // textfields with the corresponding values to update
                          //onTap: () {},
                        ),
                        DataCell(
                          Text(
                            faltaProductoAsignacion.producto.name,
                          ),
                        ),
                      ]),
                    )
                    .toList(),
              ),
            ],
          )
        ]);
  }

  Widget _textMalo() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.red.shade900,
          width: 2.0,
        ),
      ),
      child: Text(
        'aviso_noCompletado'.tr,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  Widget _textBueno() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.green[900],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.green.shade900,
          width: 2.0,
        ),
      ),
      child: Text(
        'aviso_Completado'.tr,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  bool isUsuariosCompletados() {
    bool todosCompletados = true;
    for (Ticket ticket in Constants.grupoPopulate.tickets) {
      for (Completado completado in ticket.completado) {
        if (!completado.completado) {
          todosCompletados = false;
        }
      }
    }
    return todosCompletados;
  }

  List<FaltaProductoAsignacion> faltaProductoAsignacion() {
    GrupoPopulate grupoPopulate = Constants.grupoPopulate;
    List<FaltaProductoAsignacion> faltaProductoAsignacion = [];
    for (Ticket ticket in grupoPopulate.tickets) {
      for (Producto producto in ticket.productos) {
        for (Asignacion asignacion in producto.asignaciones) {
          if (asignacion.cantidad == 0) {
            faltaProductoAsignacion
                .add(FaltaProductoAsignacion(ticket, producto));
          }
        }
      }
    }
    return faltaProductoAsignacion;
  }
}
