import 'package:flutter_application/infrastructure/models/grupo.dart';

import '../infrastructure/models/grupo_populate.dart';

abstract class GrupoRespository{
  Future<GrupoPopulate> getPopulateGrupo(String idGrupo);
  Future<List<Grupo>?> getGrupos();
  Future<bool> crearGrupo(String name, String descripcion);
  Future <bool> exitGrupo(String idGrupo);
  Future<bool> joinGrupo( String codigoGrupo);
  tablaDeudas();
  Future<bool> existeCodigo( String codigo);

}