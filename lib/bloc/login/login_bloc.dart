import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
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
    on<LoginKaKaoTalk>(_onLoginKakaoTalk);
    on<GoogleLogin>(_onGoogleLogin);
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

  void _onLoginKakaoTalk(LoginKaKaoTalk event, Emitter<LoginState> emit) async {
    bool talkInstalled = await isKakaoTalkInstalled();
    if (talkInstalled) {
      emit(LoginLoading());
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        emit(LoginSuccess(token: token.accessToken));
        await _storageService.writeSecureData(
          StorageItem('access_token', token.accessToken),
        );
        _authBloc.add(const AuthenticationStatusChanged(
            AuthenticationStatus.authenticated));
      } catch (e) {
        if (e is PlatformException && e.code == 'CANCELED') {
          return;
        }
        // If a user is not logged into Kakao Talk after installing Kakao Talk and allowing app permission, make the user log in with Kakao Account.
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('Login succeeded. ${token.accessToken}');
        } catch (e) {
          print('Login failed. $e');
          emit(LoginFailure(error: e.toString()));
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        emit(LoginSuccess(token: token.accessToken));
        await _storageService.writeSecureData(
          StorageItem('access_token', token.accessToken),
        );
        _authBloc.add(const AuthenticationStatusChanged(
            AuthenticationStatus.authenticated));
      } catch (e) {
        print('Login failed. $e');
      }
    }
  }

  void _onGoogleLogin(GoogleLogin event, Emitter<LoginState> emit) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
