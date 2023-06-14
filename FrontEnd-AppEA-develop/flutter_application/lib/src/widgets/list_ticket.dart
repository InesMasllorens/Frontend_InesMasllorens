import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/models/completado.dart';
import 'package:flutter_application/infrastructure/models/grupo.dart';
import 'package:flutter_application/infrastructure/models/grupo_populate.dart';

import 'package:flutter_application/src/list_producto_screen.dart';

import 'package:flutter_application/repositories/ticket_repository.dart';
import 'package:flutter_application/repositories/ticket_repository_impl.dart';

import 'package:flutter_application/src/widgets/info_grupo.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:provider/provider.dart';

import '../../infrastructure/models/ticket.dart';
import '../../infrastructure/models/user.dart';
import '../../utils/constants.dart';
import '../controllers/list_ticket_controller.dart';
import 'package:get/get.dart';

class ListTickets extends StatelessWidget {
  GrupoPopulate grupoPopulate = Constants.grupoPopulate;
  final TicketRespository _ticketRepository = TicketRepositoryImpl();
  List<Ticket> ticketList = Constants.grupoPopulate.tickets;
  //ListTickets(BuildContext context, {super.key});
  List<Grupo> grupoList = <Grupo>[];
  final LoadingButtonController _btnController = LoadingButtonController();
  bool completarTickets = true;
  String completarTicketsText = 'completar_tickets'.tr;
  MaterialColor color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListTicketController>(
        create: (_) => ListTicketController(),
        child: Consumer<ListTicketController>(
            builder: (_, controller, __) => Column(children: <Widget>[
                  InfoGrupo(context),
                  const Divider(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: LoadingButton(
                          iconData: Icons.file_upload,
                          onPressed: () {
                            final TicketRespository ticketRepository =
                                TicketRepositoryImpl();
                            ticketRepository.putCompletadosToTicket();
                            buttonActualizarUnidadesPressed();
                          },
                          controller: _btnController,
                          child: Text('enviar_tickets'.tr),
                        )),
                        IconButton(
                          color: color,
                          icon: const Icon(Icons.check_box),
                          onPressed: () {
                            int i = 0;
                            if (completarTickets) {
                              while (
                                  i < Constants.grupoPopulate.tickets.length) {
                                Constants.grupoPopulate.tickets[i].completado
                                    .firstWhere((completado) =>
                                        completado.usuario == Constants.user.id)
                                    .completado = true;
                                i++;
                              }
                              completarTickets = false;
                              color = Colors.green;
                              completarTicketsText =
                                  'Deseleccionar_ticket'.tr;
                            } else {
                              while (
                                  i < Constants.grupoPopulate.tickets.length) {
                                Constants.grupoPopulate.tickets[i].completado
                                    .firstWhere((completado) =>
                                        completado.usuario == Constants.user.id)
                                    .completado = false;
                                i++;
                              }
                              completarTickets = true;
                              color = Colors.grey;
                            }

                            controller.updateCompletado();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: grupoPopulate.tickets.isNotEmpty
                        ? ListView.builder(
                            itemCount: grupoPopulate.tickets.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _tickets(context, index, grupoPopulate);
                            })
                        : Text('aviso_noTickets'.tr),
                  ),
                ])));
  }

  void buttonActualizarUnidadesPressed() async {
    Future.delayed(const Duration(seconds: 1), () {
      _btnController.success();
      Future.delayed(const Duration(seconds: 1), () {
        _btnController.reset();
      });
    });
  }
  ////////
  //Widgets//
  ///////////

  Widget _tickets(
      BuildContext context, int index, GrupoPopulate grupoPopulate) {
    bool completado = Constants.grupoPopulate.tickets
        .firstWhere((ticket) => ticket.id == grupoPopulate.tickets[index].id)
        .completado
        .firstWhere((completado) => completado.usuario == Constants.user.id ,orElse: ()=>newCompletado(Constants.user.id,index))
        .completado;
    User user = grupoPopulate.users.firstWhere(
        (user) => user.id == grupoPopulate.tickets[index].anfitrion);
    return Consumer<ListTicketController>(
        builder: (_, controller, __) => Card(
              color: const Color.fromARGB(255, 197, 162, 226),
              child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ListTile(
                    onTap: () async {
                      //context.read<GrupoBloc>().add(initGrupos());
                      // context
                      //     .read<UserBloc>()
                      //     .add(getPopulateGrupo(idGrupo: grupoList[index].id));
                      // await _ticketRepository.getPopulateTicket(ticketList[index].id);

                      // Navigator.pushNamed(context, '/list_producto_screen');
                      Constants.idTicketSeleccionado =
                          Constants.grupoPopulate.tickets[index].id;
                      Constants.ticket=Constants.grupoPopulate.tickets[index];

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListProductoScreen()));
                    },
                    title: Text(grupoPopulate.tickets[index].nombre,
                        style: const TextStyle(fontSize: 30.0)),
                    subtitle: Text("${'anfitrion'.tr}: ${user.name}",
                        style: const TextStyle(fontSize: 20.0)),
                    trailing: SizedBox(
                      width: 70,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (completado) {
                                  completado = false;
                                } else {
                                  completado = true;
                                }
                                //Cambiar el estado en la constante grupoPopulate
                                Constants.grupoPopulate.tickets
                                    .firstWhere((ticket) =>
                                        ticket.id ==
                                        grupoPopulate.tickets[index].id)
                                    .completado
                                    .firstWhere((completado) =>
                                        completado.usuario == Constants.user.id)
                                    .completado = completado;
                                controller.updateCompletado();
                                // await showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       title: const Text('Confirmar'),
                                //       content: const Text(
                                //           '¿Seguro que quieres cambiar el estado de este ticket?'),
                                //       actions: <Widget>[
                                //         TextButton(
                                //           onPressed: () {
                                //             Navigator.of(context)
                                //                 .pop(); // Cerrar el AlertDialog
                                //           },
                                //           child: const Text('Cancelar'),
                                //         ),
                                //         TextButton(
                                //           onPressed: () {
                                //             if (completado) {
                                //               completado = false;
                                //             } else {
                                //               completado = true;
                                //             }
                                //             //Cambiar el estado en la constante grupoPopulate
                                //             Constants.grupoPopulate.tickets
                                //                 .firstWhere((ticket) =>
                                //                     ticket.id ==
                                //                     grupoPopulate
                                //                         .tickets[index].id)
                                //                 .completado
                                //                 .firstWhere((completado) =>
                                //                     completado.usuario ==
                                //                     Constants.user.id)
                                //                 .completado = completado;
                                //             controller.updateCompletado();

                                //             Navigator.of(context)
                                //                 .pop(); // Cerrar el AlertDialog
                                //           },
                                //           child: const Text('Sí'),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                              },
                              icon: const Icon(Icons.check_box),
                              color: completado ? Colors.green : Colors.grey),
                          IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('confirmar'.tr),
                                      content: Text(
                                          'borrar_ticket'.tr),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Cerrar el AlertDialog
                                          },
                                          child: Text('cancelar'.tr),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _ticketRepository.exitTicket(
                                                ticketList[index].id);
                                            ticketList.removeAt(index);

                                            Navigator.of(context)
                                                .pop(); // Cerrar el AlertDialog
                                          },
                                          child: Text('si'.tr),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  )),
            ));
  }
  Completado newCompletado(String idUser,int index){
    Completado completado=Completado(id: "id", usuario: idUser, completado: false, createdAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"), updatedAt: DateTime.parse("2023-05-09T06:54:07.810+00:00"));
    Constants.grupoPopulate.tickets
        .firstWhere((ticket) => ticket.id == grupoPopulate.tickets[index].id)
        .completado.add(completado);
    return completado;
  }
}
