import 'package:dio/dio.dart';
import 'package:terafty_flutter/constants/api_constant.dart';
import 'package:terafty_flutter/models/popular_content_model.dart';
import 'package:terafty_flutter/services/api_provider.dart';

class PopularRepository {
  final _api = Api();
  final Dio _dio = Dio();

  Future<List<Doc>> getPopularContent() async {
    List<Doc> popular;
    try {
      Response response = await _api.dio.get(
        '$baseURL/web-app/popular-content',
        queryParameters: {'limit': 20.toString()},
      );
      PopularContent movieRes = PopularContent.fromJson(response.data);
      popular = movieRes.data.docs;
      return popular;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      throw error;
    } catch (exception) {
      rethrow;
    }
  }

  Future<List<dynamic>> getBanner() async {
    List<dynamic> listBanner;
    try {
      Response res = await _dio.get('$baseURL/web-app/banner');
      if (res.statusCode == 200) {
        listBanner = res.data['data']['imageMobileOversea'];
      } else {
        listBanner = [];
        throw Exception('Cannot get banner api');
      }
      return listBanner;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      throw error;
    } catch (exception) {
      rethrow;
    }
  }
}
