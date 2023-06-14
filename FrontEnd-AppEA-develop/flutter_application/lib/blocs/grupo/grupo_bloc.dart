import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_application/infrastructure/models/grupo.dart';
import 'package:flutter_application/infrastructure/models/grupo_populate.dart';
import 'package:flutter_application/repositories/grupo_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/grupo_repository.dart';
import '../../repositories/user_repository.dart';
import '../../repositories/user_repository_impl.dart';

part 'grupo_event.dart';
part 'grupo_state.dart';

class GrupoBloc extends Bloc<GrupoEvent, GrupoState> {
  late GrupoRespository _grupoRepository;
  late UserRespository _userRepository;

  GrupoBloc() : super(const GrupoState()) {
    _grupoRepository = GrupoRepositoryImpl();
    _userRepository = UserRepositoryImpl();

    on<InitGrupos>((event, emit){
      emit(state.copyWith(loading: true));

    });

    on<GetGruposOfUser>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        // To do
        final resp = await _userRepository.getGruposOfUser();
        emit(state.copyWith(listGrupos: resp,loading: false));
        
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
  }
}
