import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/models/grupo_populate.dart';
import 'package:flutter_application/infrastructure/models/ticket.dart';
import 'package:flutter_application/src/list_grupo_screen.dart';
import 'package:flutter_application/src/widgets/drawer.dart';
import 'package:flutter_application/src/widgets/list_deudas.dart';
import 'package:flutter_application/src/widgets/list_ticket.dart';
import 'package:flutter_application/src/widgets/chat.dart';
import 'package:flutter_application/src/widgets/map.dart';
import 'package:flutter_application/utils/constants.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../repositories/grupo_repository.dart';
import '../repositories/grupo_repository_impl.dart';

import 'package:get/get.dart';

class ListTicketScreen extends StatefulWidget {
  //late String idUser;
  const ListTicketScreen({super.key});

  @override
  State<ListTicketScreen> createState() => _ListTicketScreenState();
}

class _ListTicketScreenState extends State<ListTicketScreen>
    with SingleTickerProviderStateMixin {
  final GrupoRespository _grupoRepository = GrupoRepositoryImpl();
  late GrupoPopulate grupoPopulate;

  AnimationController? _animationController;
  Animation<double>? _animation;
  bool cargado = true;
  dynamic selected = 0;
  PageController controller = PageController();
  List<Ticket> ticketlist = <Ticket>[];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    //context.read<UserBloc>().add(initGrupos());

    grupoPopulate = Constants.grupoPopulate;

    _grupoRepository.tablaDeudas();

    cargado = false;

    super.initState();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 228, 226, 221),
    drawer: DrawerWidget(),
    appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                //Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListGrupoScreen(),
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
                      title: Text('Tickets'),
                      content: Text('btn_ayuda_tickets'.tr),
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
      centerTitle: true,
      title: Text(
        "${'grupo'.tr}: ${grupoPopulate.name}", style:
        TextStyle(fontFamily: 'aBlackLives', fontSize: 30.0, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      shadowColor: const Color.fromRGBO(128, 119, 119, 0.973),
      backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Tickets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_exchange),
          label: 'deudas'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'mapa'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Chat',
        ),
      ],
      currentIndex: selected,
      selectedItemColor: Color.fromRGBO(128, 119, 119, 0.973),
      onTap: (index) {
        controller.jumpToPage(index);
        setState(() {
          selected = index;
        });
      },
    ),
    floatingActionButton: selected == 0 ? FloatingActionBubble(
      items: <Bubble>[
        Bubble(
          title: 'crear_ticket'.tr,
          iconColor: Colors.white,
          bubbleColor: Color.fromRGBO(128, 119, 119, 0.973),
          icon: Icons.library_add,
          titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
          onPress: () async {
            Navigator.pushNamed(context, '/crearticket_screen');
            _animationController!.reverse();
          },
        ),
        Bubble(
          title: 'editar_pantalla'.tr,
          iconColor: Colors.white,
          bubbleColor: Color.fromRGBO(128, 119, 119, 0.973),
          icon: Icons.create,
          titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            _animationController!.reverse();
          },
        ),
      ],
      animation: _animation!,
      onPress: () => _animationController!.isCompleted
          ? _animationController!.reverse()
          : _animationController!.forward(),
      backGroundColor: Color.fromRGBO(128, 119, 119, 0.973),
      iconColor: Colors.white,
      iconData: Icons.add_outlined,
    ) : null, // Don't show the floating button for other screens
    body: SafeArea(
      child: PageView(
        controller: controller,
        children: [
          ListTickets(),
          ListDeudas(context),
          Map(context),
          Chat(context),
        ],
      ),
    ),
  );
}

  Widget _bubble() {
    return FloatingActionBubble(
      items: <Bubble>[
        Bubble(
          title: 'crear_ticket'.tr,
          iconColor: Colors.white,
          bubbleColor: const Color.fromRGBO(128, 119, 119, 0.973),
          icon: Icons.library_add,
          titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
          onPress: () async {
            {
              Navigator.pushNamed(context, '/crearticket_screen');
            }
            _animationController!.reverse();
          },
        ),
        Bubble(
          title: 'editar_pantalla'.tr,
          iconColor: Colors.white,
          bubbleColor: const Color.fromRGBO(128, 119, 119, 0.973),
          icon: Icons.create,
          titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
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
