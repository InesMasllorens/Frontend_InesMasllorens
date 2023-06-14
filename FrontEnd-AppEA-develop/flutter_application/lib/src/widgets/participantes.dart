import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants.dart';

import '../../infrastructure/models/grupo_populate.dart';
import '../../infrastructure/models/ticket.dart';
import 'package:get/get.dart';

class Participantes extends StatelessWidget {
  final GrupoPopulate grupoPopulate = Constants.grupoPopulate;
  Participantes(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
          textStyle: const TextStyle(
            fontFamily: 'NerkoOne',
            fontSize: 20.0,
          )),
      onPressed: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('participantes'.tr),
                content: Card(
                    color: const Color.fromARGB(255, 197, 162, 226),
                    child: GestureDetector(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: grupoPopulate.users
                            .map((user) => ListTile(
                                  title: Text('${user.name} ${user.surname}'),
                                  trailing: Icon(
                                    Icons.check_box,
                                    color: isUserComplete(user.id),
                                  ),
                                ))
                            .toList(),
                      ),
                      onTap: () async {
                        //await _grupoRepository.getPopulateGrupo(grupoList[index].id);

                        //Navigator.pushNamed(context, '/list_ticket_screen');
                      },
                    )),
                actions: <Widget>[
                  TextButton(
                    child:Text('cerrar'.tr),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
      child: Text("${'participantes'.tr}: ${grupoPopulate.users.length}"),
    );
  }

  MaterialColor isUserComplete(String idUser) {
    //Buscamos si hay algun completado falso de este usuario
    bool encontrado = false;
    bool hayAlgunCompletado =
        false; //Esto nos sirve para cuando un usuario no tiene ningun completado en ningun ticket
    for (Ticket ticket in Constants.grupoPopulate.tickets) {
      int i = 0;
      hayAlgunCompletado = false;
      while (!encontrado && i < ticket.completado.length) {
        if (ticket.completado[i].usuario == idUser) {
          hayAlgunCompletado = true;
          if (!ticket.completado[i].completado) {
            encontrado = true;

            return Colors.grey;
          }
        }

        i++;
      }
    }
    if (!hayAlgunCompletado) {
      return Colors.grey;
    }
    return Colors.green;
  }
}
