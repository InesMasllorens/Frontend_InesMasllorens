import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants.dart';
import 'package:flutter_application/infrastructure/models/user.dart';

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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Algunos datos de ejemplo
  String userName = "";
  String userEmail = "";
  late User user;
  //late String profileImageUrl1;

  @override
  void initState() {
    user = Constants.user;
    //profileImageUrl1 = Faker().image.image();
    super.initState();
    //getInfoUser();
  }

  void _selectProfilePhoto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona una foto de perfil'),
          content: const Text('Aquí puedes elegir una foto de perfil'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar la ventana emergente
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () {
                // Aquí puedes guardar la foto de perfil seleccionada
                Navigator.of(context).pop(); // Cerrar la ventana emergente
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('perfil'.tr,style:
                                TextStyle(fontFamily: 'aBlackLives', fontSize: 30.0, color: Colors.white)),
          shadowColor: const Color.fromRGBO(128, 119, 119, 0.973),
          backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
        ),
        body: ListView(children: [
          // Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('images/fondo.png'),
          //       fit: BoxFit.cover,
          //       alignment: Alignment.center,
          //     ),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: _selectProfilePhoto,
                  child: Container(
                    padding:const EdgeInsets.all(14.0),
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 104, 96, 139),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        //radius: 60,
                        backgroundImage: AssetImage(nombresImagenes[indiceAleatorio]),
                        //backgroundImage: AssetImage('images/imagenperfil.png'),
                        radius: 70,
                        backgroundColor: Colors.transparent,
                        //backgroundImage: AssetImage('images/logo.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    user.name,
                    //userName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    user.email,
                    //userEmail,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
    
         ]));
  }

  /*Future getInfoUser() async {
    final response = await Dio().get('http://${dotenv.env['IP_DEVICE']}:3002/user/idUser');
    final data = response.data;
    if (response.statusCode==200){
      setState(() {
      this.UserName=response.data['name'];
      this.UserEmail=response.data['email'];
      return true;
      });
      }
    else {
      return false;
      }
    
  }*/
}
