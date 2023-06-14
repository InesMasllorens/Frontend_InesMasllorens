import 'package:flutter/material.dart';
import '../repositories/grupo_repository.dart';
import '../repositories/grupo_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import 'list_grupo_screen.dart';

import 'package:get/get.dart';

class CrearGrupoScreen extends StatefulWidget {
  const CrearGrupoScreen({super.key});

  @override
  CrearGrupoScreenState createState() => CrearGrupoScreenState();
}

class CrearGrupoScreenState extends State<CrearGrupoScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  bool _showErrorMessage = false;
  final GrupoRespository _grupoRepository = GrupoRepositoryImpl();
  final UserRespository _userRepository = UserRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 228, 226, 221),
        appBar: AppBar(
          centerTitle: true,
          title: Text('nuevo_grupo'.tr,
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
                      title: Text('crear_grupo'.tr),
                      content: Text(
                          'btn_ayuda_crearGrupos'.tr),
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
        body: Stack(
          children: [
            ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'nombre_grupo'.tr,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          errorStyle: const TextStyle(color: Colors.red),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value == "" || value == null) {
                            return 'Porfavor introduce un nombre de grupo';
                          }
                          return null;
                        },
                      ),
                      Visibility(
                        visible: _showErrorMessage,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'control_nombre'.tr,
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
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: 'descripcion_grupo'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        validator: (value) {
                          if (value == "" || value == null) {
                            return 'Porfavor introduce la descripción de grupo';
                          }
                          return null;
                        },
                      ),
                      const Divider(
                        height: 18.0,
                      ),
                    ]),
  
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
                          nameController.text == "") {
                        setState(() {
                          _showErrorMessage = true;
                        });
                        return;
                      }
                      try {
                        bool response = await _grupoRepository.crearGrupo(
                            nameController.text, descriptionController.text);
                        await _userRepository.getGruposOfUser();

                        if (response) {
                          Navigator.pushNamed(context, '/list_grupo_screen');
                        } else {
                          Future.delayed(Duration.zero, () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('control_añadirGrupo'.tr),
                              backgroundColor: Theme.of(context).primaryColor,
                            ));
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('crear_grupo'.tr),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
