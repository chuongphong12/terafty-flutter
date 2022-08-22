import 'dart:async';

import 'package:dio/dio.dart';
import 'package:terafty_flutter/constants/api_constant.dart';
import 'package:terafty_flutter/models/user_model.dart';
import 'package:terafty_flutter/services/api_provider.dart';

class UserRepository {
  final _api = Api();
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    Response response = await _api.dio.get('$baseURL/user/me');
    return _user = User.fromJson(response.data);
  }
}
