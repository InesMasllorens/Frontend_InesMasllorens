import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/src/widgets/participantes.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import '../../infrastructure/models/grupo_populate.dart';
import '../../infrastructure/models/ticket.dart';
import '../../utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:get/get.dart';



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
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  showShareDialog(context, grupoPopulate.codigo);
                },
              ),
            ),
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



void showShareDialog(BuildContext context, String code) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('compartir'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildShareOption(
                Icons.share,
                "WhatsApp",
                () {
                  Navigator.of(context).pop();
                  shareCodeOnWhatsApp(code);
                },
              ),
              _buildShareOption(
                Icons.email,
                'email'.tr,
                () {
                  Navigator.of(context).pop();
                  shareCodeByEmail(code);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareOption(
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onPressed,
    );
  }

  void shareCodeOnWhatsApp(String code) {
    if (html.window.navigator.userAgent.contains("Chrome") ||
        html.window.navigator.userAgent.contains("Firefox")) {
      final webUrl =
          "https://web.whatsapp.com/send?text= ${'enviar_codigo'.tr}: $code!";
      html.window.open(webUrl, '_blank');
    } else {
      final mobileUrl =
          "https://wa.me/?text=¡Únete ${'enviar_codigo'.tr}: $code!";
      html.window.open(mobileUrl, '_blank');
    }
  }

  void shareCodeByEmail(String code) {
    final emailSubject = 'unir_codigo'.tr;
    final emailBody = '${'enviar_codigo'.tr}: $code!';

    final emailUrl = Uri.encodeFull('mailto:?subject=$emailSubject&body=$emailBody');
    html.window.open(emailUrl, '_blank');
  }

}
