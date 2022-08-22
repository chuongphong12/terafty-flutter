part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final AuthenticationStatus status;

  const AuthAuthenticated({
    required this.user,
    required this.status,
  });

  @override
  List<Object> get props => [user];
}

class AuthUnAuthenticated extends AuthState {
  final AuthenticationStatus status;

  const AuthUnAuthenticated(this.status);

  @override
  List<Object> get props => [status];
}

class AuthLoading extends AuthState {}
