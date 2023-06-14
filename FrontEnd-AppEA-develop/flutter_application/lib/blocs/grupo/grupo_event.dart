part of 'grupo_bloc.dart';

@immutable
abstract class GrupoEvent extends Equatable{
  const GrupoEvent();

  @override
  List<Object> get props => [];
}

class GetPopulateGrupo extends GrupoEvent{
  final String idGrupo;
  const GetPopulateGrupo({required this.idGrupo});
}

class GetGruposOfUser extends GrupoEvent{
}
class InitGrupos extends GrupoEvent{
  
}
