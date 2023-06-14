import 'package:flutter/material.dart';

void main() {
  runApp(const InfoScreen());
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 234, 233, 233),
      appBar: AppBar(
          title: const Text('FLUTTER EXERCISE',style:
                                TextStyle(fontFamily: 'aBlackLives', fontSize: 30.0, color: Colors.white)),
          shadowColor: const Color.fromRGBO(128, 119, 119, 0.973),
          backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
          ),
      body: 
      Stack(
            children: const [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    'Obtain the ID of the logged user and show the basic information of this user in the ‘Profile’ section. :)',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Pacifico',
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.grey,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
      ) 
    );
  }
}
