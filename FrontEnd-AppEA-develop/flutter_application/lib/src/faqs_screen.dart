
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const FaqsScreen());
}

class FaqItem {
  final String pregunta;
  final String respuesta;

  FaqItem({required this.pregunta, required this.respuesta});
}

List<FaqItem> faqs = [
  FaqItem(
    pregunta: 'pregunta1'.tr,
    respuesta:
        'respuesta1'.tr,
  ),
  FaqItem(
    pregunta: 'pregunta2'.tr,
    respuesta:
        'respuesta2'.tr,
  ),
  FaqItem(
    pregunta: 'pregunta3'.tr,
    respuesta:
        'respuesta3'.tr,
  ),
  FaqItem(
    pregunta: 'pregunta4'.tr,
    respuesta:
        'respuesta4'.tr,
  ),
];

class FaqItemWidget extends StatelessWidget {
  final FaqItem faq;

  const FaqItemWidget({super.key, required this.faq});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(faq.pregunta),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(faq.respuesta),
        ),
      ],
    );
  }
}

class FaqListWidget extends StatelessWidget {
  final Widget child;

  const FaqListWidget({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return FaqItemWidget(faq: faqs[index]);
      },
    );
  }
}

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 226, 221),
      appBar: AppBar(
                    title:Text('FAQS'.tr,style:
                                TextStyle(fontFamily: 'aBlackLives', fontSize: 30.0, color: Colors.white)),
          shadowColor: const Color.fromRGBO(128, 119, 119, 0.973),
          backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973)),
      body: FaqListWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(128, 119, 119, 0.973),
                  textStyle: const TextStyle(
                    fontFamily: 'NerkoOne',
                    fontSize: 30.0,
                  ),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, '/list_grupo_screen');
                },
                child: const Text(
                    'Texto del botón'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}