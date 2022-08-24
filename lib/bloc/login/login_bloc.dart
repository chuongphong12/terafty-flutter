import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:terafty_flutter/bloc/auth/auth_bloc.dart';
import 'package:terafty_flutter/models/storage_item.dart';
import 'package:terafty_flutter/repository/auth_repository.dart';
import 'package:terafty_flutter/services/storage_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositories _authRepositories;
  final StorageService _storageService;
  final AuthBloc _authBloc;
  LoginBloc({
    required AuthRepositories authRepositories,
    required AuthBloc authBloc,
    required StorageService storageService,
  })  : _authRepositories = authRepositories,
        _authBloc = authBloc,
        _storageService = storageService,
        super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginExecuted);
  }

  void _onLoginExecuted(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final token = await _authRepositories.logIn(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess(token: token));
      await _storageService.writeSecureData(
        StorageItem('access_token', token),
      );
      _authBloc.add(const AuthenticationStatusChanged(
          AuthenticationStatus.authenticated));
    } catch (e) {
      debugPrint(e.toString());
      emit(LoginFailure(error: e.toString()));
    }
  }
}
