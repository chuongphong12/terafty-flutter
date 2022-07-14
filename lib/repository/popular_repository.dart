import 'package:dio/dio.dart';
import 'package:terafty_flutter/constants/api_constant.dart';
import 'package:terafty_flutter/models/popular_content_model.dart';
import 'package:terafty_flutter/services/api_provider.dart';

class PopularRepository {
  final _api = Api();

  Future<List<Doc>> getPopularContent() async {
    List<Doc>? popular;
    try {
      Response response = await _api.dio.get('$baseURL/web-app/popular-content');
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
}
