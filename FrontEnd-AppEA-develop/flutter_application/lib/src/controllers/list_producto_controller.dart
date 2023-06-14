import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:flutter_application/infrastructure/models/grupo_populate.dart';
import 'package:flutter_application/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../repositories/grupo_repository.dart';
import '../../repositories/grupo_repository_impl.dart';

 class ListProductoController extends ChangeNotifier {
   GrupoPopulate _grupoPopulateUpdate=Constants.grupoPopulate;
  GrupoPopulate get grupoPopulate => _grupoPopulateUpdate;
  final GrupoRespository _grupoRepository = GrupoRepositoryImpl();
  //onTap Mapa
  void updateGrupoPopulate(String idGrupo )async{
   _grupoPopulateUpdate= await _grupoRepository.getPopulateGrupo(idGrupo);
    notifyListeners();

  }

//Control errores
  bool _showErrorMessage = false;
  bool get showErrorMessage=>_showErrorMessage;

  bool showErrorMessageName = false;
  bool showErrorMessageCantidad = false;
  bool ShowErrorMessagePrice = false;

  void updateShowErrorMessage(bool estado){
    _showErrorMessage=estado;
    notifyListeners();
  }

  void updateShowErrorMessageName(bool estado){
    showErrorMessageName=estado;
    notifyListeners();
  }

  void updateShowErrorMessageCantidad(bool estado){
    showErrorMessageCantidad=estado;
    notifyListeners();
  }

  void updateShowErrorMessagePrice(bool estado){
    ShowErrorMessagePrice=estado;
    notifyListeners();
  }






  
}