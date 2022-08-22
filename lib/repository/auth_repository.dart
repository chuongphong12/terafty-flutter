import 'dart:async';

import 'package:dio/dio.dart';
import 'package:terafty_flutter/constants/api_constant.dart';
import 'package:terafty_flutter/models/user_model.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepositories {
  final Dio _dio = Dio();
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<String> logIn({
    required String email,
    required String password,
  }) async {
    User? user;
    try {
      Response response = await _dio.post('$baseURL/user/login', data: {
        'userEmail': email,
        'userPassword': password,
        'language': 'english',
        'typeDevice': 'app'
      });
      User user = User.fromJson(response.data);
      if (response.statusCode == 200) {
        return user.data.token;
      } else {
        throw Exception('Failed to login');
      }
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      if (error['password'] != null) {
        throw error['password'];
      } else {
        throw error['email'];
      }
    } catch (exception) {
      rethrow;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
