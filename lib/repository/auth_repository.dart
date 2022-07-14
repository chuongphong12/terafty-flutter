import 'package:dio/dio.dart';
import 'package:terafty_flutter/constants/api_constant.dart';
import 'package:terafty_flutter/models/user_model.dart';

class AuthRepositories {
  final Dio _dio = Dio();

  Future<String> login(String email, String password) async {
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
}
