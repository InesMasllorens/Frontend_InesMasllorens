
import 'package:dio/dio.dart';
import 'package:flutter_application/infrastructure/models/user.dart';
import 'package:flutter_application/repositories/user_repository.dart';

import '../infrastructure/models/grupo.dart';
import '../infrastructure/models/ticket.dart';
import '../utils/constants.dart';


class UserRepositoryImpl extends UserRespository {
  String path = '${Constants.apiUrl}/auth';

  @override
  Future<User> loginUser(String email, String password) async {
    var response = await Dio()
        .post("$path/login", data: {"email": email, "password": password});
        var userAndToken = response.data as Map;
    Constants.token = userAndToken['token'];
    Constants.user = User.fromJson(userAndToken['user']);

    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }

    /*if (Constants.user.password != password){
      throw Exception('El password no es válido');
    }*/
    //return Constants.user;
    return User.fromJson(userAndToken['user']);
  }

  @override
  Future<bool> registerUser(
      String name, String surname, String email, String password) async {
    var response = await Dio().post("$path/register", data: {
      "name": name,
      "surname": surname,
      "email": email,
      "password": password,
      "role": "User"
    });
    if (response.statusCode == 200) {
      return true;
    } 
    else if(response.statusCode == 212){
      return false;
    }
    else {
      throw Exception('Failed to register user');
    }
  }

   @override
  Future<List<Grupo>?> getGruposOfUser() async {
    String path1 = '${Constants.apiUrl}/user';
    List<Grupo> grupoList = <Grupo>[];
    try {
      var response = await Dio().get('$path1/grupos/${Constants.user.id}',
          options: Options(headers: {'Authorization': Constants.token}));
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }

      var registros = response.data as List;
      for (var sub in registros) {
        grupoList.add(Grupo.fromJson(sub));
      }
      grupoList.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      Constants.listGrupos = grupoList;
      return grupoList;
    } catch (e) {
      return null;
    }
  }


     @override
  Future<List<Ticket>?> getTicketsOfGrupo() async {
    String path1 = '${Constants.apiUrl}/grupo';
    List<Ticket> ticketList = <Ticket>[];
    try {
      var response = await Dio().get('$path1/${Constants.grupoPopulate.id}/tickets',
          options: Options(headers: {'Authorization': Constants.token}));
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }

      var registros = response.data as List;
      for (var sub in registros) {
        ticketList.add(Ticket.fromJson(sub));
      }

      ticketList.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      Constants.listTickets = ticketList;
      return ticketList;
    } catch (e) {
      return null;
    }
  }
  @override
  Future<bool> registerUserGoogle(
      String name, String surname, String email, String password) async {
    var response = await Dio().post("$path/registerGoogle", data: {
      "name": name,
      "surname": surname,
      "email": email,
      "password": password,
      "role": "User"
    });
    if (response.statusCode == 200) {
      return true;
    } 
    else if(response.statusCode == 212){
      return false;
    }
    else {
      throw Exception('Failed to register user');
    }
  }

}
