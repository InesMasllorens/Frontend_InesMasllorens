import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/models/asignacion.dart';
import 'package:flutter_application/infrastructure/models/grupo.dart';
import 'package:flutter_application/infrastructure/models/producto.dart';
import 'package:collection/collection.dart';
import 'package:flutter_application/src/list_ticket_screen.dart';
import 'package:loading_icon_button/loading_icon_button.dart';

import 'package:flutter_application/src/widgets/drawer.dart';
import 'package:flutter_application/utils/constants.dart';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:provider/provider.dart';

import '../repositories/producto_repository.dart';
import '../repositories/producto_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import 'package:flutter_application/infrastructure/models/ticket.dart';

import 'controllers/list_producto_controller.dart';
import 'package:get/get.dart';

class ListProductoScreen extends StatelessWidget {
  final UserRespository _userRepository = UserRepositoryImpl();
  final ProductoRespository _productoRepository = ProductoRepositoryImpl();

  List<Grupo> grupoList = <Grupo>[];
  AnimationController? _animationController;
  Animation<double>? _animation;
  List<Ticket> ticketlist = Constants.grupoPopulate.tickets;

  List<Asignacion> listAsignacions = <Asignacion>[];

  final emailController = TextEditingController();
  final LoadingButtonController _btnController = LoadingButtonController();

  var nameController = TextEditingController();
  var quantityController = TextEditingController();
  var totalpriceController = TextEditingController();
  var idTicket;

  bool formatoName(String nameController) {
    final RegExp nombreRegex = RegExp(r'^[a-zA-Z]+$');
    return !nombreRegex.hasMatch(nameController);
  }

  bool formatoCantidad(String quantityController) {
  final RegExp numeroRegex = RegExp(r'^[0-9]+$');
  return !numeroRegex.hasMatch(quantityController);
  }

  bool formatototalprice(String totalpriceController) {
  final RegExp numeroRegex = RegExp(r'^[0-9]+(\.[0-9]+)?$');
  return !numeroRegex.hasMatch(totalpriceController);
}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListProductoController>(
      create: (_) => ListProductoController(),
      child: Scaffold(
        //backgroundColor: const Color.fromARGB(255, 228, 226, 221),
        drawer:
            const DrawerWidget(), //llamamos funcion widget _drawerWidget en la carpeta widgets
        appBar: AppBar(
          centerTitle: true,

          title: Text('${'productos'.tr}: ${Constants.ticket.nombre}',
              style: TextStyle(
                  fontFamily: 'aBlackLives',
                  fontSize: 30.0,
                  color: Colors.white)),

          shadowColor: const Color.fromRGBO(128, 119, 119, 0.973),
          backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                //Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListTicketScreen(),
                    ));
              },
            ),
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('añadir_producto'.tr),
                      content: Text('btn_ayuda_listaProductos'.tr),
                      actions: [
                        TextButton(
                          child: Text('cerrar'.tr),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/fondo.jpeg'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Consumer<ListProductoController>(
            builder: (_, controller, __) => ListView(
              children: <Widget>[
                controller.grupoPopulate.tickets
                        .firstWhere((element) =>
                            element.id == Constants.idTicketSeleccionado)
                        .productos
                        .isNotEmpty
                    ? DataTable(
                        columns: [
                          DataColumn(
                            label: Text('cantidad'.tr),
                          ),
                          DataColumn(
                            label: Text('nombre_producto'.tr),
                          ),
                          DataColumn(
                            label: Text('precio_total'.tr),
                          ),
                          DataColumn(
                            label: Text('unidades_pagar'.tr),
                          ),
                        ],
                        rows: controller.grupoPopulate.tickets
                            .firstWhere((element) =>
                                element.id == Constants.idTicketSeleccionado)
                            .productos
                            .map(
                              (p) => DataRow(cells: [
                                DataCell(
                                  Text(p.quantity.toString()),
                                ),
                                DataCell(
                                  Text(p.name),
                                ),
                                DataCell(
                                  Text(p.totalprice.toString()),
                                ),
                                DataCell(
                                  Counter(p: p),
                                )
                              ]),
                            )
                            .toList(),
                      )
                    : Text('control_productos_ticket'.tr),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: quantityController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(
                                255, 255, 255, 255), // Color del fondo
                            hintText: 'cantidad'.tr,
                            labelText: 'cantidad'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSubmitted: (valor) {},
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(
                                255, 255, 255, 255), // Color del fondo
                            hintText: 'nombre_producto'.tr,
                            labelText: 'nombre_producto'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        onSubmitted: (valor) {},
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: totalpriceController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(
                                255, 255, 255, 255), // Color del fondo
                            hintText: 'precio_total'.tr,
                            labelText: 'precio_total'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        onSubmitted: (valor) {},
                      ),
                    ),
                    Expanded(
                        child: IconButton(
                            onPressed: () async {
                              if (nameController.text == "" ||
                                  quantityController.text == "" ||
                                  totalpriceController.text == "") {
                                controller.updateShowErrorMessage(true);
                                // setState(() {
                                //   showErrorMessage = true;
                                // });
                                return;
                              } else if (formatoName(nameController.text)) {
                                controller.updateShowErrorMessageName(true);
                                return;
                              }

                              else if (formatoCantidad(quantityController.text)) {
                                controller.updateShowErrorMessageCantidad(true);
                                return;
                              }

                              else if (formatototalprice(totalpriceController.text)) {
                                controller.updateShowErrorMessagePrice(true);
                                return;
                              }

                              await addProdcutoTicket();
                              controller.updateGrupoPopulate(
                                  Constants.grupoPopulate.id);
                            },
                            icon: const Icon(Icons.add_circle_outline))),
                  ],
                ),
                Visibility(
                  visible: controller.showErrorMessageName,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'formato_incorrecto'.tr,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 18.0,
                ),


                            Visibility(
                  visible: controller.showErrorMessageCantidad,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'formato_cantidad'.tr,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 18.0,
                ),


                  Visibility(
                  visible: controller.ShowErrorMessagePrice,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'formato_price'.tr,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 18.0,
                ),






                Visibility(
                  visible: controller.showErrorMessage,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'control_CamposObligatorios'.tr,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 18.0,
                ),
                LoadingButton(
                  iconData: Icons.file_upload,
                  onPressed: () => buttonActualizarUnidadesPressed(),
                  controller: _btnController,
                  child: Text('actualizar_unidades'.tr),
                ),
       
              ],
            ),
          )
        ]),
      ),
    ); //llamamos funcion widget _floatButton
  }

  void buttonActualizarUnidadesPressed() async {
    asigancionProducto();
    Future.delayed(const Duration(seconds: 1), () {
      _btnController.success();
      Future.delayed(const Duration(seconds: 1), () {
        _btnController.reset();
      });
    });
  }

  ////////
  //Widgets
  ////////

  addProdcutoTicket() async {
    await _productoRepository.insertProductotoTicket(
        nameController.text,
        quantityController.text,
        totalpriceController.text,
        Constants.idTicketSeleccionado);
  }

  asigancionProducto() {
    List<Producto> listProductos = Constants.grupoPopulate.tickets
        .firstWhere((ticket) => ticket.id == Constants.idTicketSeleccionado)
        .productos;
    String idUser = Constants.user.id;
    idTicket;
    var bucle = 0;
    List<dynamic> productosAsignados = [];
    String productoseleccionado;

    while (bucle < listProductos.length) {
      productoseleccionado = listProductos[bucle].id;
      productosAsignados.add({
        'idProducto': productoseleccionado,
        'cantidad': listProductos[bucle]
            .asignaciones
            .firstWhere((asignacion) => asignacion.usuario == Constants.user.id)
            .cantidad
      });

      bucle++;
    }
    _productoRepository.putAsignacionToProducto(idUser, productosAsignados);
  }
}

class Counter extends StatefulWidget {
  Producto p;
  Counter({super.key, required this.p});
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _itemCount = 0;
  @override
  void initState() {
    _itemCount = widget.p.asignaciones.firstWhereOrNull(
                (asignacion) => asignacion.usuario == Constants.user.id) !=
            null
        ? widget.p.asignaciones
            .firstWhere((asignacion) => asignacion.usuario == Constants.user.id)
            .cantidad
        : 0;
    if (widget.p.asignaciones.firstWhereOrNull(
            (asignacion) => asignacion.usuario == Constants.user.id) ==
        null) {
      Asignacion asignacion = Asignacion(
          id: "id",
          usuario: Constants.user.id,
          cantidad: 0,
          createdAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"),
          updatedAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"));
      widget.p.asignaciones.add(asignacion);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.secondary),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  _itemCount != 0 ? _itemCount-- : _itemCount;
                  widget.p.asignaciones
                      .firstWhere((asignacion) =>
                          asignacion.usuario == Constants.user.id)
                      .cantidad = _itemCount;
                });
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 16,
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: Text(
              _itemCount.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  _itemCount++;
                  widget.p.asignaciones
                      .firstWhere((asignacion) =>
                          asignacion.usuario == Constants.user.id)
                      .cantidad = _itemCount;
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              )),
        ],
      ),
    );
  }
}
