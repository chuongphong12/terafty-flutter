import 'package:dio/dio.dart';
import 'package:terafty_flutter/constants/api_constant.dart';

class AuthRepositories {
  final Dio _dio = Dio();

  Future<String> login(String email, String password) async {
    try {
      Response response = await _dio.post('$baseURL/customer/login', data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        return response.data['data']['access_token'];
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
