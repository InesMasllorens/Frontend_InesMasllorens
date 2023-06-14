import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/models/user.dart';
import 'package:flutter_application/repositories/user_repository.dart';
import 'package:flutter_application/repositories/user_repository_impl.dart';
import 'package:meta/meta.dart';

import '../../infrastructure/models/grupo.dart';
import '../../infrastructure/models/grupo_populate.dart';
import '../../repositories/grupo_repository.dart';
import '../../repositories/grupo_repository_impl.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late UserRespository _userRepository;
  late GrupoRespository _grupoRepository;

  UserBloc() : super(const UserState()) {
    _userRepository = UserRepositoryImpl();
    _grupoRepository = GrupoRepositoryImpl();

    on<UserInit>(
        ((event, emit) => emit(state.copyWith(loading: false, error: ""))));

    on<LoginUser>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        // To do
        final resp =
            await _userRepository.loginUser(event.email, event.password);
        emit(state.copyWith(user: resp, loading: false));
      } catch (error) {
        try {
          emit(state.copyWith(
              loading: false, error: (error as dynamic)['message']));
        } catch (error) {
          emit(state.copyWith(loading: false, error: 'Ocurrio un error'));
        }
      }
    });

    on<GetPopulateGrupo>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        // To do
        final resp = await _grupoRepository.getPopulateGrupo(event.idGrupo);
        emit(state.copyWith(loading: false, grupoPopulate: resp));
      } catch (error) {
        try {
          emit(state.copyWith(
              loading: false, error: (error as dynamic)['message']));
        } catch (error) {
          emit(state.copyWith(loading: false, error: 'Ocurrio un error'));
        }
      }
    });
    
    on<GetGruposOfUser>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        // To do
        final resp = await _userRepository.getGruposOfUser();

        emit(state.copyWith(listGrupos: resp, loading: false));
      } catch (error) {
        try {
          emit(state.copyWith(
              loading: false, error: (error as dynamic)['message']));
        } catch (error) {
          emit(state.copyWith(loading: false, error: 'Ocurrio un error'));
        }
      }
    });
  }
}
