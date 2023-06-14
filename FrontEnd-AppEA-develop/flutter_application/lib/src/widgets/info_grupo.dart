import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/src/widgets/participantes.dart';
import 'package:get/get.dart';

import '../../infrastructure/models/grupo_populate.dart';
import '../../infrastructure/models/ticket.dart';
import '../../utils/constants.dart';

class InfoGrupo extends StatelessWidget {
  GrupoPopulate grupoPopulate = Constants.grupoPopulate;
  List<Ticket> ticketList = Constants.grupoPopulate.tickets;
  InfoGrupo(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text.rich(
                TextSpan(
                  children: [
                   TextSpan(
                        text: 'codigo'.tr,
                        style: TextStyle(
                          fontFamily: 'NerkoOne',
                          fontSize: 20.0,
                        )),
                    TextSpan(
                        text: grupoPopulate.codigo,
                        style: const TextStyle(
                          fontFamily: 'NerkoOne',
                          fontSize: 30.0,
                        )),
                    WidgetSpan(
                        child: IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: grupoPopulate.codigo));
                            },
                            icon: const Icon(Icons.copy))),
                  ],
                ),
              )),
              Participantes(context),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "${'descripcion'.tr}: ${grupoPopulate.descripcion}",
                  style: const TextStyle(
                    fontFamily: 'NerkoOne',
                    fontSize: 20.0,
                  ),
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }

  void buttonPressed() async {}
}
