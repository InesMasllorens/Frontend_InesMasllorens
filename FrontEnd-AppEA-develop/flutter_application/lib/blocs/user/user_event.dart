part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();

   @override
  List<Object> get props => [];
}

class LoginUser extends UserEvent{
  final String email;
  final String password;
  const LoginUser({required this.email, required this.password});
}

class UserInit extends UserEvent{
}

class GetPopulateGrupo extends UserEvent{
  final String idGrupo;
  const GetPopulateGrupo({required this.idGrupo});
}

class GetGruposOfUser extends UserEvent{
}
class InitGrupos extends UserEvent{
}
