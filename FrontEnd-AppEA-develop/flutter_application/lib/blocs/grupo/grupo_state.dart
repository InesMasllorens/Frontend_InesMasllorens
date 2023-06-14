part of 'grupo_bloc.dart';

@immutable
class GrupoState extends Equatable {
  final bool loading;
  final String error;
  final bool add;
  final bool removed;
  final GrupoPopulate? grupoPopulate;
  final List<Grupo>? listGrupos;

  const GrupoState( 
      {this.loading = true,
      this.error = '',
      this.add = false,
      this.removed = false,
      this.grupoPopulate,
      this.listGrupos,});

  GrupoState copyWith({
    bool? loading,
    String? error,
    bool? add,
    bool? removed,
    GrupoPopulate? grupoPopulate,
    List<Grupo>? listGrupos,
  }) =>
      GrupoState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        add: add ?? this.add,
        removed: removed ?? this.removed,
        grupoPopulate: grupoPopulate ?? this.grupoPopulate,
        listGrupos: listGrupos?? this.listGrupos,
      );

  @override
  List<Object?> get props => [loading,error,add,removed,grupoPopulate,listGrupos];
}
