import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/models/grupo.dart';
import 'package:flutter_application/src/login_screen.dart';
import 'package:label_marker/label_marker.dart';

import 'package:flutter_application/src/widgets/drawer.dart';
import 'package:flutter_application/utils/constants.dart';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../infrastructure/models/ticket.dart';
import '../repositories/grupo_repository.dart';
import '../repositories/grupo_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';

import 'package:get/get.dart';

class ListGrupoScreen extends StatefulWidget {
  //late String idUser;
  const ListGrupoScreen({super.key});

  @override
  State<ListGrupoScreen> createState() => _ListGrupoScreenState();
}

class _ListGrupoScreenState extends State<ListGrupoScreen>
    with SingleTickerProviderStateMixin {
  final GrupoRespository _grupoRepository = GrupoRepositoryImpl();
  final UserRespository _userRepository = UserRepositoryImpl();

  List<Grupo> grupoList = <Grupo>[];
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    //context.read<UserBloc>().add( getGruposOfUser());

    //getGrupos();
    _userRepository.getGruposOfUser();

    grupoList = Constants.listGrupos;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: const Color.fromARGB(255, 228, 226, 221),
        drawer:
            const DrawerWidget(), //llamamos funcion widget _drawerWidget en la carpeta widgets
        appBar: AppBar(
          centerTitle: true,

          title:Text('titulo_grupo'.tr,
              style: TextStyle(
                  fontFamily: 'aBlackLives',
                  fontSize: 30.0,
                  color: Colors.white)),
          shadowColor: const Color.fromRGBO(128, 119, 119, 0.973),
          backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
          actions: [
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('grupos'.tr),
                      content: Text('btn_ayuda_grupos'.tr),

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
          Column(children: [
            const Divider(
              height: 18.0,
            ),
            Expanded(
              child: grupoList.isNotEmpty
                  ? ListView.builder(
                      itemCount: grupoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _grupo(context, index,
                            grupoList); //llamamos funcion widget _grupo
                      })
                  : Text('aviso_noGrupos'.tr,
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
            )
          ]),
        ]),
        floatingActionButton:
            _floatButton(context)); //llamamos funcion widget _floatButton
  }

  Widget _grupo(BuildContext context, int index, List<Grupo> grupoList) {
    return Card(
      color: const Color.fromARGB(255, 197, 162, 226),
      child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListTile(
            onTap: () async {

              await _grupoRepository.getPopulateGrupo(grupoList[index].id);
              for (Ticket ticket in Constants.grupoPopulate.tickets) {
                List<String> latlong = ticket.location.split(",");
                double latitude = double.parse(latlong[0]);
                double longitude = double.parse(latlong[1]);
                LatLng location = LatLng(latitude, longitude);


                final markerId =
                    MarkerId(Constants.markers.length.toString());

                final marker = LabelMarker(
                    label: ticket.nombre,
                    markerId: markerId,
                    position: location,
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

                Constants.markers.addLabelMarker(marker);

                //_controllerMap.addMarker(location);

              }

              Navigator.pushNamed(context, '/list_ticket_screen');
            },
            title: Text(grupoList[index].name,
                style: const TextStyle(fontSize: 30.0)),

            subtitle: Text(" ${'codigo'.tr} ${grupoList[index].codigo}",
                style: const TextStyle(fontSize: 20.0)),

            trailing: SizedBox(
              width: 70,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('confirmar'.tr),
                              content: Text(
                                  'aviso_borrarGrupo'.tr),
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
                                    setState(() {
                                      _grupoRepository
                                          .exitGrupo(grupoList[index].id);
                                      grupoList.removeAt(index);
                                    });
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
                      icon: const Icon(Icons.delete))
                ],
              ),
            ),
          )),
    );
  }

  Widget _floatButton(BuildContext context) {
    return FloatingActionBubble(
      items: <Bubble>[
        Bubble(
          title: 'crear_grupo'.tr,
          iconColor: Colors.white,
          bubbleColor: const Color.fromRGBO(128, 119, 119, 0.973),
          icon: Icons.library_add,
          titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
          onPress: () async {
            {
              Navigator.pushNamed(context, '/creargrupo_screen');
            }

            _animationController!.reverse();
          },
        ),
        Bubble(
          title: "unirse_grupo".tr,
          iconColor: Colors.white,
          bubbleColor: const Color.fromRGBO(128, 119, 119, 0.973),
          icon: Icons.group_add,
          titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            {
              Navigator.pushNamed(context, '/unirsegrupo_screen');
            }

            _animationController!.reverse();
          },
        ),
      ],
      animation: _animation!,
      onPress: () => _animationController!.isCompleted
          ? _animationController!.reverse()
          : _animationController!.forward(),
      backGroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
      iconColor: Colors.white,
      iconData: Icons.add_outlined,
    );
  }
}
