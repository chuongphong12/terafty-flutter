import 'package:dio/dio.dart';
import 'package:terafty_flutter/constants/api_constant.dart';
import 'package:terafty_flutter/models/episode_model.dart';
import 'package:terafty_flutter/models/streaming_model.dart';
import 'package:terafty_flutter/services/api_provider.dart';

class StreamingRepository {
  final _api = Api();

  Future<StreamingData> getStreamingDetail(String? id) async {
    try {
      Response response =
          await _api.dio.get('$baseURL/web-app/streaming/authen/$id');
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

  Future<List<dynamic>> getAllSeasonByStreamID(String streamID) async {
    List<dynamic> seasons = [];
    try {
      Response response = await _api.dio.get(
          '$baseURL/web-app/streaming/season/get-all-season-of-streaming',
          queryParameters: {'streamingID': streamID});
      seasons = response.data['data'];
      return seasons;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      print(error);
      throw error;
    } catch (exception) {
      rethrow;
    }
  }

  Future<List<Episode>> getAllEpisodeByStreamIDAndSeason({
    required String streamID,
    required String seasonID,
  }) async {
    List<Episode> episodes = [];
    try {
      Response response = await _api.dio.get(
          '$baseURL/web-app/streaming/streaming-episodes/get-list-episodes-by-season',
          queryParameters: {'streamingID': streamID, 'seasonID': seasonID});
      EpisodeResponse epRes = EpisodeResponse.fromJson(response.data);
      episodes = epRes.data;
      return episodes;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      print(error);
      throw error;
    } catch (exception) {
      rethrow;
    }
  }
}
