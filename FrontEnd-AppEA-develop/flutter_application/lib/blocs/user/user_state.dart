part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  final bool loading;
  final String error;
  final User? user;
   final GrupoPopulate? grupoPopulate;
  final List<Grupo>? listGrupos;


  const UserState( 
      {this.loading = true,
      this.error = '',
      this.user,
      this.grupoPopulate,
      this.listGrupos,});

  UserState copyWith( {
    bool? loading,
    String? error,
    User? user,
    GrupoPopulate? grupoPopulate,
    List<Grupo>? listGrupos,
  }) =>
      UserState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        user: user ?? this.user,
         grupoPopulate: grupoPopulate ?? this.grupoPopulate,
        listGrupos: listGrupos?? this.listGrupos,
      );

  @override
  List<Object?> get props => [loading,error,user,grupoPopulate,listGrupos];
}



