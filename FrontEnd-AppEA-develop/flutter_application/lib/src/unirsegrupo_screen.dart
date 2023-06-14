import 'package:flutter/material.dart';
import 'package:flutter_application/src/list_grupo_screen.dart';
import '../repositories/grupo_repository.dart';
import '../repositories/grupo_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import 'package:get/get.dart';



class UnirseGrupoScreen extends StatefulWidget {

 


  const UnirseGrupoScreen({super.key});

   @override
  UnirseGrupoScreenState createState() => UnirseGrupoScreenState();

}
  class UnirseGrupoScreenState extends State<UnirseGrupoScreen> {
  final codigoController = TextEditingController();
  bool showErrorMessage = false;
   final GrupoRespository _grupoRepository = GrupoRepositoryImpl();
  final UserRespository _userRepository = UserRepositoryImpl();


  /*@override
  void dispose() {
    codigoController.dispose();
    super.dispose();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 226, 221),
      appBar: AppBar(
                 centerTitle: true,
          title: Text('unir_grupo'.tr,
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
                      title: Text('unir_grupo'.tr),
                      content: Text('btn_ayuda_unirGrupo'.tr),
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
      body: 
      Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: codigoController,
                        decoration: InputDecoration(
                            labelText: 'codigo_grupo'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        validator: (value) {
                          if (value == "" || value == null) {
                            return 'Porfavor introduce el codigo del grupo';
                          }
                          return null;
                        },
                      ),

                      Visibility(
                      visible: showErrorMessage,
                      child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                      'control_codigo'.tr,
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
                                if (codigoController.text == "" || codigoController.text == "") {
                                setState(() {
                                showErrorMessage = true;
                              });
                              return;
                              }
          
                            try{
                              
                            bool ok=await _grupoRepository.joinGrupo(codigoController.text);
                            await _userRepository.getGruposOfUser();
                            
                            if (ok) {
                              Navigator.pushNamed(context, '/list_grupo_screen');

                            } else {
                              Future.delayed(Duration.zero, () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('error_unirse'.tr),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                        ));
                                      });
                            }
                          }
                            catch (e) {
                            print(e);
                          }
                          },
                          child: Text('unir_grupo'.tr),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]
      )    
    );
  }

}
