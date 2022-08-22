import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:terafty_flutter/models/storage_item.dart';
import 'package:terafty_flutter/models/user_model.dart';
import 'package:terafty_flutter/repository/auth_repository.dart';
import 'package:terafty_flutter/repository/user_repository.dart';
import 'package:terafty_flutter/services/storage_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories _authRepositories;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  final StorageService _storageService;
  AuthBloc({
    required AuthRepositories authRepositories,
    required StorageService storageService,
    required UserRepository userRepository,
  })  : _authRepositories = authRepositories,
        _storageService = storageService,
        _userRepository = userRepository,
        super(AuthInitial()) {
    // on<AppStarted>(_onAppStarted);
    // on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    _authenticationStatusSubscription = _authRepositories.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authRepositories.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(
            const AuthUnAuthenticated(AuthenticationStatus.unauthenticated));
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthAuthenticated(
                  user: user, status: AuthenticationStatus.authenticated)
              : const AuthUnAuthenticated(AuthenticationStatus.unauthenticated),
        );
      case AuthenticationStatus.unknown:
        return emit(AuthInitial());
    }
  }

  // void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
  //   final bool hasToken = await _storageService.hasToken();
  //   if (hasToken) {
  //     emit(const AuthAuthenticated());
  //   } else {
  //     emit(const AuthUnAuthenticated());
  //   }
  // }

  // void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   await _storageService.writeSecureData(
  //     StorageItem('access_token', event.token),
  //   );
  //   emit(const AuthAuthenticated(AuthenticationStatus.authenticated));
  // }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _storageService.deleteAllSecureData();
    _authRepositories.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
