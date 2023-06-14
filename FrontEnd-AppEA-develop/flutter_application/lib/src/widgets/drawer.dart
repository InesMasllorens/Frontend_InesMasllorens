import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/models/user.dart';
import '../../utils/constants.dart';

import 'package:get/get.dart';

List<String> nombresImagenes = [
  'assets/profilepicture1.png',
  'assets/profilepicture2.png',
  'assets/profilepicture3.png',  
  'assets/profilepicture4.png',
  'assets/profilepicture5.png',
  'assets/profilepicture6.png',
];

Random random = Random();
int indiceAleatorio = random.nextInt(nombresImagenes.length);
String nombreImagenAleatoria = nombresImagenes[indiceAleatorio];

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>{

  late User user;
  late int indiceAleatorio;
  late String nombreImagenAleatoria;

  _DrawerWidgetState() {
    user = Constants.user;
    indiceAleatorio = Random().nextInt(nombresImagenes.length);
    nombreImagenAleatoria = nombresImagenes[indiceAleatorio];
  }

  @override
  Widget build (BuildContext context){

    
    return Drawer(
            child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    DrawerHeader(
                        child: Column(
                      children: [
                        Expanded(
                            child: Image.asset(nombresImagenes[indiceAleatorio])),
                        Text(
                    user.name,
                    //userName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                        const SizedBox(height: 10, width: 100)
                      ],
                    )),
                    ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('perfil'.tr),
                        onTap: () {
                          Navigator.pushNamed(context, '/profile_screen');
                        }),
                    ListTile(
                        leading: const Icon(Icons.people),
                        title: Text('quien_somos'.tr),
                        onTap: () {
                          Navigator.pushNamed(context, '/equipo_screen');
                        }),
                    ListTile(
                        leading: const Icon(Icons.question_mark),
                        title: Text('FAQS'.tr),
                        onTap: () {
                          Navigator.pushNamed(context, '/faqs_screen');
                        }),
                    ListTile(
                        leading: const Icon(Icons.play_circle),
                        title: const Text('Tutorial'),
                        onTap: () {
                          Navigator.pushNamed(context, '/tutorial_screen');
                        }), 
                    ListTile(
                        leading: const Icon(Icons.people),
                        title: Text('idioma'.tr),
                        onTap: () {
                          Navigator.pushNamed(context, '/idioma_screen');
                        }),   
                    ListTile(
                        leading: const Icon(Icons.logout),
                        title: Text('cerrar_sesion'.tr),
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        }),
  
                  ],
                )),
          );
  }
}