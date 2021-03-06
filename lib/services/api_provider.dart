import 'package:dio/dio.dart';
import 'package:terafty_flutter/services/storage_service.dart';

class Api {
  Dio dio = Dio();
  String? accessToken;

  final _storage = StorageService();

  Api() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          accessToken = await _storage.readSecureData('access_token');
          if (!options.path.contains('http')) {
            options.path = 'http://3.39.229.249:3000/${options.path}';
          }
          if (accessToken != null && accessToken != '') {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioError error, handler) {
          if (error.response?.statusCode == 401) {
            _storage.deleteAllSecureData();
          }
          return handler.next(error);
        },
      ),
    );

    Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
      final options = Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      );
      return dio.request<dynamic>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options,
      );
    }
  }
}
