import 'package:flutter/material.dart';
import 'package:flutter_application/repositories/ticket_repository.dart';
import 'package:flutter_application/repositories/ticket_repository_impl.dart';
import 'package:flutter_application/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../repositories/grupo_repository.dart';
import '../repositories/grupo_repository_impl.dart';
import '../utils/controller_map.dart';
import 'list_ticket_screen.dart';
import 'package:get/get.dart';

class CrearTicketScreen extends StatefulWidget {
  const CrearTicketScreen({super.key});

  @override
  CrearTicketScreenState createState() => CrearTicketScreenState();
}

class CrearTicketScreenState extends State<CrearTicketScreen> {
  final nameController = TextEditingController();
  final localizationController = TextEditingController();
  bool _showErrorMessage = false;
  final GrupoRespository _grupoRepository = GrupoRepositoryImpl();
  final TicketRespository _ticketRepository = TicketRepositoryImpl();
  String localization="";

  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ControllerMap>(create: (_)=>ControllerMap(),child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 228, 226, 221),
        appBar: AppBar(
             centerTitle: true,
          title: Text('nuevo_ticket'.tr,
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
                      title: Text('crear_ticket'.tr),
                      content: Text('btn_ayuda_crearTicket'.tr),
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
          ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'nombre_ticket'.tr,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      errorStyle: const TextStyle(color: Colors.red),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return 'Please introduce the group name';
                      }
                      return null;
                    },
                  ),
                  const Divider(
                    height: 18.0,
                  ),
                  TextFormField(
                    controller: localizationController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        labelText: 'coordenadas'.tr,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return 'Please introduce the ticket coordinates';
                      }
                      return null;
                    },
                  ),
                  const Divider(
                    height: 18.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 300.0,
                    child: Consumer<ControllerMap>(builder:(_,controller,__)=>GoogleMap(
                      //Tiene que estar en un Scaffold o en un SizedBox
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(0, 0),
                      ),
                      markers: controller.marker,
                      onTap: (position) {
                        //Acciones que sucederan si clicamos. "postion" son las cordenadas donde se han clicado
                        localization=position.toString();
                        localization=localization.split("(")[1];
                        localization=localization.substring(0,localization.length-1);
                        localizationController.text=localization;
                        controller.onTap(position);
                      },
                    ), ),
                  ),
                  Visibility(
                    visible: _showErrorMessage,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'control_camposRellenos'.tr,
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
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromRGBO(128, 119, 119, 0.973),
                          textStyle: const TextStyle(
                            fontFamily: 'NerkoOne',
                            fontSize: 30.0,
                          )),
                      onPressed: () async {
                        if (nameController.text == "" ||
                            nameController.text == "" ||
                            localizationController.text == "" ||
                            localizationController.text == "") {
                          setState(() {
                            _showErrorMessage = true;
                          });
                          return;
                        }
                        try {
                          bool response = await _ticketRepository.crearTicket(
                              nameController.text, localizationController.text);
                          await _grupoRepository
                              .getPopulateGrupo(Constants.grupoPopulate.id);
                          //await _userRepository.getTicketsOfGrupo();

                          if (response) {
                            Navigator.pushNamed(context, '/list_ticket_screen');
                          } else {
                            Future.delayed(Duration.zero, () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'ticket_añadido'.tr),
                                backgroundColor: Theme.of(context).primaryColor,
                              ));
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('crear_ticket'.tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]))
  ,);
    }
}
