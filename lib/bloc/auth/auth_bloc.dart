import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:terafty_flutter/models/storage_item.dart';
import 'package:terafty_flutter/repository/auth_repository.dart';
import 'package:terafty_flutter/services/storage_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories _authRepositories;
  final StorageService _storageService;
  AuthBloc(
      {required AuthRepositories authRepositories,
      required StorageService storageService})
      : _authRepositories = authRepositories,
        _storageService = storageService,
        super(AuthUnInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final bool hasToken = await _storageService.hasToken();
    if (hasToken) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnAuthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _storageService.writeSecureData(
      StorageItem('access_token', event.token),
    );
    emit(AuthAuthenticated());
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _storageService.deleteAllSecureData();
    emit(AuthUnAuthenticated());
  }
}
