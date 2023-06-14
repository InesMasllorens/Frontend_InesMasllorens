import 'package:flutter/material.dart';
import 'list_grupo_screen.dart';

import 'package:get/get.dart';

void main() {
  runApp(EquipoScreen());
}

class EquipoScreen extends StatelessWidget {
  final List<String> listaItems = [
    'Arnau Millán Gutiérrez',
    'Carme Alcalá-Bejarano Masachs',
    'Victòria Roman Garrido',
    'Inés Masllorens Doria',
    'Alba Serra Muchart',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Desactivar el banner de debug
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'titulo_equipo'.tr,
            style: TextStyle(
              fontFamily: 'aBlackLives',
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          shadowColor: const Color.fromRGBO(128, 119, 119, 0.973),
          backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListGrupoScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Container(
          color: Color.fromARGB(255, 189, 207, 221),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 200.0, left: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'quien_somos'.tr,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'aBlackLives',
                          color: Colors.black, // Text color
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'texto'.tr,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black, // Text color
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listaItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  '• ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black, // Text color
                                  ),
                                ),
                                Text(
                                  listaItems[index],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black, // Text color
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'texto2'.tr,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 40.0),
              Container(
                width: 500.0, // Desired image width
                height: 500.0, // Desired image height
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('images/equipo.jpg'), // Image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}