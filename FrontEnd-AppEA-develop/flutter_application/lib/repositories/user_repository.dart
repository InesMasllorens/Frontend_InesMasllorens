import 'package:flutter_application/infrastructure/models/grupo.dart';

import '../infrastructure/models/ticket.dart';
import '../infrastructure/models/user.dart';

abstract class UserRespository{
  Future<User> loginUser(String email,String password);
  Future <bool> registerUser(String name, String surname, String email, String password);
  Future<List<Grupo>?> getGruposOfUser();
  Future<List<Ticket>?> getTicketsOfGrupo();
  Future <bool> registerUserGoogle(String name, String surname, String email, String password);
}