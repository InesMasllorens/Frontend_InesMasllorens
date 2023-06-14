import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectedLocale = Locale('es', 'ES').obs;

  void updateLanguage(Locale locale) {
    selectedLocale.value = locale;
    Get.updateLocale(locale);
  }
}