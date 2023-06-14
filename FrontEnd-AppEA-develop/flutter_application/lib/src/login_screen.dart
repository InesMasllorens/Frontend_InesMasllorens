import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application/src/widgets/square_tile.dart';
import 'package:flutter_application/utils/auth_services.dart';

import 'package:flutter_application/src/controllers/language_controller.dart';
import 'package:flutter_application/src/register_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../blocs/user/user_bloc.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserRespository _userRepository = UserRepositoryImpl();

  late String idUser = "";
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool showErrorMessage = false;
  bool showErrorMessageValidar = false;
  bool showPassword = false;
  int idioma = 2;
  
  void getUserData() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? firstName = user.displayName?.split(' ')[0];
      String? lastName = user.displayName?.split(' ')[1];
      String? email = user.email;
      String? password = user.email;
      
      bool isEmailRegistered = await _userRepository.registerUserGoogle(firstName!, lastName!, email!, password!);
                          
      print('Nombre: $firstName');
      print('Apellido: $lastName');
      print('Email: $email');
      print('Password: $password');
      print(isEmailRegistered);
      if (isEmailRegistered){
        try {
          await _userRepository.loginUser(
            email!,
            password!,
          );
          await _userRepository.getGruposOfUser();
          Navigator.pushNamed(
              context, '/list_grupo_screen');
        } on LoginUser {
          setState(() {
            showErrorMessageValidar = true;
          });
        } catch (e) {
          setState(() {
            showErrorMessageValidar = true;
          });
        }  
      }    
    } else {
      print('No hay un usuario autenticado');
    }
  } catch (e) {
    print('Error al obtener los datos del usuario: $e');
  }
}


  @override
  void initState() {
    context.read<UserBloc>().add(UserInit());

    super.initState();
  }
  
  updatelanguage(Locale locale){
    Get.updateLocale(locale);
    Get.back();

  }


  final List locale =[
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'Español', 'locale': Locale('es', 'ES')},
  ];

  builddialog(BuildContext context){
    showDialog
    (
      context:context,
      builder: (builder){
        return AlertDialog(
          title: Text('escoge_idioma'.tr),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context,index){

                return Padding(
                  padding:const EdgeInsets.all(8.0),
                  child: GestureDetector (
                    onTap: (){
                      print(locale[index]['name']);
                      updatelanguage(locale[index]['locale']);
                    },
                     child: Text(locale[index]['name']),
                  )
                  
                 
                );
                
              }, 
              separatorBuilder: (context,index){
                return Divider(
                  color: const Color.fromRGBO(128, 119, 119, 0.973),
                );
              }, 
              itemCount: locale.length
              ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
            //backgroundColor: Color.fromARGB(255, 212, 209, 209),
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
          ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
              children: <Widget>[




                Column(
                  mainAxisAlignment: MainAxisAlignment.center,


                  
                  children: [
                       Align(
  alignment: Alignment.topRight,
  child: ElevatedButton(
    onPressed: () {
      builddialog(context);
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(128, 119, 119, 0.973)),
    ),
    child: Text(
      'idioma'.tr,
      style: TextStyle(
        fontFamily: 'aBlackLives',
        fontSize: 16.0,
      ),
    ),
  ),
),
                    const CircleAvatar(
                      radius: 100.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('images/logo.png'),
                    ),
                    const SizedBox(
                      width: 160.0,
                      height: 15.0,
                    ),
                    Text('iniciar sesion'.tr,
                        style: TextStyle(
                            fontFamily: 'aBlackLives',
                            //fontFamily: 'Roboto',
                            fontSize: 45.0,
                            color: Colors.white)),
                    const SizedBox(
                      width: 160.0,
                      height: 15.0,
                      child: Divider(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(
                              255, 255, 255, 255), // Color del fondo
                          hintText: 'email'.tr,
                          labelText: 'email'.tr,
                          suffixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      onSubmitted: (valor) {},
                    ),
                    const Divider(
                      height: 18.0,
                    ),

                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                            labelText: 'contraseña'.tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          obscureText: !showPassword,
                          onChanged: (value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == "") {
                              return 'Porfavor introduzca la contraseña';
                            }
                            return null;
                          },
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    /*
                    TextField(
                      controller: passwordController,
                      enableInteractiveSelection: true,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(
                              255, 255, 255, 255), // Color del fondo
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      onSubmitted: (valor) {},
                    ),*/

                    Visibility(
                      visible: showErrorMessageValidar,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: AlertDialog(
                            title: Text('usuario_incorrecto'.tr),
                            content: Text(
                              'control_usuarioNoExiste'.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showErrorMessageValidar = false;
                                  });
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 160.0,
                      height: 15.0,
                      child: Divider(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    Visibility(
                      visible: showErrorMessage,
                      child:  Align(
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
                                fontFamily: 'aBlackLives',
                                fontSize: 20.0,
                              )),
                          onPressed: () async {
                            if (emailController.text == "" ||
                                passwordController.text == "") {
                              setState(() {
                                showErrorMessage = true;
                              });
                              return;
                            }

                            try {
                              await _userRepository.loginUser(
                                emailController.text,
                                passwordController.text,
                              );
                              await _userRepository.getGruposOfUser();
                              Navigator.pushNamed(
                                  context, '/list_grupo_screen');
                            } on LoginUser {
                              setState(() {
                                showErrorMessageValidar = true;
                              });
                            } catch (e) {
                              setState(() {
                                showErrorMessageValidar = true;
                              });
                            }

                          },
                          child: Text('btn_continuar'.tr),
                        )),
                    const SizedBox(height: 30),
                    Text(
                      'aviso'.tr,
                      style: TextStyle(
                          fontFamily: 'aBlackLives',
                          fontSize: 14.0,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_screen');
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(128, 119, 119, 0.973))),
                      child: Text(
                        'btn_registrarse'.tr,
                        style: TextStyle(
                            fontFamily: 'aBlackLives', fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SquareTile(
                          imgagePath: 'images/google.png',
                          onTap: () async {
                            await AuthServices().signInWithGoogle();
                            getUserData();
                          },
                        ),
                      ],
                    )
                  ],
                )
              ]),
        ]));
      },
    );
  }
}
