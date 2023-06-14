import 'package:flutter/material.dart';
import 'list_grupo_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(TutorialScreen());
}

class TutorialScreen extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: const Text(
            'TUTORIAL',
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('images/paso1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'crea_un_grupo'.tr,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aBlackLives',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('images/paso2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'comparte_codigo'.tr,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aBlackLives',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('images/paso3.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'crea_tickets'.tr,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aBlackLives',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('images/paso4.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'añade_productos'.tr,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aBlackLives',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('images/paso5.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'selecciona_productos'.tr,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aBlackLives',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('images/paso6.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'valida_seleccion'.tr,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aBlackLives',
                            color: Colors.black,
                          ),
                        ),
                      ]
                      ),
                      Column(
                      children: [
                        Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('images/paso7.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'resuelve_deudas'.tr,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aBlackLives',
                            color: Colors.black,
                          ),
                        ),
                      ],
                      ),
                      ],
                    ),
                  ],
                ),
            ),
          ),
        )
    );
  }
}
