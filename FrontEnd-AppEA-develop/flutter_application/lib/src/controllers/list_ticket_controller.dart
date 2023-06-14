import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:flutter_application/infrastructure/models/grupo_populate.dart';
import 'package:flutter_application/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../infrastructure/models/completado.dart';
import '../../repositories/grupo_repository.dart';
import '../../repositories/grupo_repository_impl.dart';

class ListTicketController extends ChangeNotifier {
  bool completadoTF=false;
  //onTap Mapa
  void updateCompletado()  {
    
    notifyListeners();
  }

//Control errores
  bool _showErrorMessage = false;
  bool get showErrorMessage => _showErrorMessage;

  bool showErrorMessageName = false;

  void updateShowErrorMessage(bool estado) {
    _showErrorMessage = estado;
    notifyListeners();
  }

  void updateShowErrorMessageName(bool estado) {
    showErrorMessageName = estado;
    notifyListeners();
  }
}
