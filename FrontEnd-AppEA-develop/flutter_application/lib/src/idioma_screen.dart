import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application/src/controllers/language_controller.dart';
import 'package:flutter_application/src/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../blocs/user/user_bloc.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdiomaScreen extends StatefulWidget {
  const IdiomaScreen({super.key});
  

  @override
  State<IdiomaScreen> createState() => _IdiomaScreenState();
}

class _IdiomaScreenState extends State<IdiomaScreen> {

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
    return Scaffold(
      appBar: AppBar(
          title: Text('idioma'.tr,style:
                                TextStyle(fontFamily: 'aBlackLives', fontSize: 30.0, color: Colors.white)),
          shadowColor: const Color.fromRGBO(128, 119, 119, 0.973),
          backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
        ),


      body: Center(



        
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
    );
  }
}