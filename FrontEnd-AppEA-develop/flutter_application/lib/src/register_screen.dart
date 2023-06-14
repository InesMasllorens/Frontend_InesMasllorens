
import 'package:flutter/material.dart';
import 'package:flutter_application/src/LocaleString.dart';
import 'package:flutter_application/src/controllers/language_controller.dart';
import 'package:flutter_application/utils/constants.dart';

import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';

import 'dart:core';
import 'package:get/get.dart';



class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});


  @override
  RegisterScreenState createState() => RegisterScreenState();

}
class RegisterScreenState extends State<RegisterScreen> {

  //final LanguageController languageController = Get.find();

  final UserRespository _userRepository = UserRepositoryImpl();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  bool showErrorMessage = false;
  bool showErrorMessagePassword = false;
  bool showErrorMessageEmail = false;
  bool showErrorMessageValidarPsw = false;



  bool showPassword = false;


  bool formatoEmail(String emailController) {

  final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(emailController);
  }
  
  bool formatoPassword(String passwordController) {
  if (passwordController.length < 8 || !passwordController.contains(RegExp(r'\d')) || !passwordController.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) { // Tenga al menos 8 caracteres, Tenga al menos un número, Tenga al menos un carácter especial
    return false;
  }

  return true;
}


  Color getPasswordStrengthColor(String password) {
    if (password.isEmpty) {
      return Colors.transparent;
    }

    if (password.length < 8 ||
        !password.contains(RegExp(r'\d')) &&
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return Colors.red;
    } else if (password.length >= 8 &&
        password.contains(RegExp(r'\d')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return Colors.green;
    } else {
      return Colors.yellow;
    }
  }


  @override
  Widget build(BuildContext context) {
    //final LanguageController languageController = Get.find();
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 212, 209, 209),
      appBar: AppBar(
          shadowColor: const Color.fromRGBO(128, 119, 119, 0.973),
          backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973)),

                    body: Stack (
            children: [
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
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

Padding(
  padding: EdgeInsets.only(top: 10.0), // Espacio de margen arriba
  child: Text(
    textAlign: TextAlign.center,
    'register'.tr,
       
    style: TextStyle(
      fontFamily: 'aBlackLives',
      //fontFamily: 'Roboto',
      fontSize: 50.0,
      color: Colors.white,
   
    ),
  ),
),
const SizedBox(
  width: 160.0,
  height: 15.0,
  child: Divider(color: Color.fromARGB(255, 255, 255, 255)),
),  


                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          labelText: 'nombre'.tr,
                          //labelText: 'nombre'.tr,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return 'Porfavor introduce el nombre';
                        }
                        return null;
                      },
                    ),

                    const Divider(
                      height: 18.0,
                    ),
                    TextFormField(
                      controller: surnameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          labelText: 'apellido'.tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return 'Porfavor introduce tu apellido';
                        }
                        return null;
                      },
                    ),

                    const Divider(
                      height: 18.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                        labelText: 'email'.tr,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == "") {
                          return 'Porfavor introduce tu correo electrónico';
                        }
                        return null;
                      },
                    ),

                    Visibility(
                    visible: showErrorMessageEmail,
                    child: Visibility(
                    visible: !formatoEmail(emailController.text),
                    child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                    'control_FormatoEmail'.tr,
                    style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    ),
                    ),
                    ),
                    ),
                    ),
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
                          return 'Porfavor introduce una contraseña';
                        }
                        return null;
            },
          ),

          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
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
          

                                    Container(
                  height: 5,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: getPasswordStrengthColor(passwordController.text),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                                              Visibility(
                    visible: showErrorMessageValidarPsw,
                    child: Visibility(
                    visible: !formatoPassword(passwordController.text),
                    child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                    'control_FormatoContraseña'.tr,
                    style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    ),
                    ),
                    ),
                    ),
                    ),
                    ),

                    const Divider(
                      height: 18.0,
                    ),

                                       Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            controller: passwordController2,
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
                          return 'Porfavor introduce una contraseña';
                        }
                        return null;
            },
          ),

          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
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

     Visibility(
                    visible: showErrorMessagePassword,
                    child: Visibility(
                    visible: passwordController.text != passwordController2.text,
                    child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                    'control_ConstraseñasIguales'.tr,
                    style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    ),
                    ),
                    ),
                    ),
                    ),
                                                              ),

                    const Divider(
                      height: 18.0,
                    ),

                                  Visibility(
                    visible: showErrorMessage,
                    child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                    'control_CamposObligatorios'.tr,
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
                              fontSize: 25.0,
                            )),
                        onPressed: () async {
                            if (nameController.text == "" || surnameController.text == "" || emailController.text == "" || passwordController.text == "" || passwordController2.text == "") {
                              setState(() {
                              showErrorMessage = true;
                            });
                            return;
                            }

                            else if (passwordController.text != passwordController2.text) {
                            setState(() {
                            showErrorMessagePassword = true;
                            });
                            return;
                            }

                            else if (!formatoEmail(emailController.text)) {
                            setState(() {
                            showErrorMessageEmail = true;
                            });
                            return;
                            }

                            else if (!formatoPassword(passwordController.text)) {
                            setState(() {
                            showErrorMessageValidarPsw = true;
                            });
                            return;
                            }

                          bool isEmailRegistered = await _userRepository.registerUser(nameController.text, surnameController.text, emailController.text, passwordController.text);
                          if (!isEmailRegistered) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Error"),
                                content: Text('control_EmailExistente'.tr),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }

                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text('control_UsuarioRegistrado'.tr),
                            backgroundColor: Theme.of(context).primaryColor,
                            ),
                            );

                          Navigator.pushNamed(context, '/login_screen');

                        },
                        child: Text('btn_registrarse'.tr),
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

