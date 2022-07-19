import 'package:dio/dio.dart';
import 'package:terafty_flutter/constants/api_constant.dart';
import 'package:terafty_flutter/models/streaming_model.dart';
import 'package:terafty_flutter/services/api_provider.dart';

class StreamingRepository {
  final _api = Api();

  Future<StreamingData> getStreamingDetail(String? id) async {
    try {
      Response response = await _api.dio.get('$baseURL/web-app/streaming/$id');
      Streaming streamRes = Streaming.fromJson(response.data);

      return streamRes.data;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      print(error);
      throw error;
    } catch (exception) {
      rethrow;
    }
  }

  
}
