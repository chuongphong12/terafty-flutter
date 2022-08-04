import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:terafty_flutter/constants/api_constant.dart';
import 'package:terafty_flutter/models/comment_model.dart';
import 'package:terafty_flutter/models/episode_model.dart';
import 'package:terafty_flutter/models/stream_detail_model.dart';
import 'package:terafty_flutter/models/streaming_model.dart';
import 'package:terafty_flutter/models/vote_model.dart';
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
          '$baseURL/web-app/streaming/streaming-episodes/get-all-episodes-of-streaming',
          queryParameters: {'streamingID': streamID});
      EpisodeResponse epRes = EpisodeResponse.fromJson(response.data);
      episodes =
          epRes.data.where((episode) => episode.seasonId == seasonID).toList();
      return episodes;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      print(error);
      throw error;
    } catch (exception) {
      rethrow;
    }
  }

  Future<List<dynamic>> getListEpisodeByStreamIDAndSeason({
    required String streamID,
    required String seasonID,
  }) async {
    List<dynamic> episodes = [];
    try {
      Response response = await _api.dio.get(
          '$baseURL/web-app/streaming/streaming-episodes/get-list-episodes-by-season',
          queryParameters: {
            'streamingID': streamID,
            'seasonID': seasonID,
          });
      episodes = response.data['data'] as List<dynamic>;
      episodes = episodes
          .where((value) => value['deleted'] != true)
          .where((value) => value['seasonID'] == seasonID)
          .toList();
      return episodes;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      print(error);
      throw error;
    } catch (exception) {
      rethrow;
    }
  }

  Future<StreamDetail> getDetailBySeason(
      {required String seasonId, required String streamingId}) async {
    try {
      Response res = await _api.dio
          .get('$baseURL/web-app/streaming/season/$seasonId', queryParameters: {
        'streamingID': streamingId,
      });
      StreamDetailResponse streamRes = StreamDetailResponse.fromJson(res.data);
      return streamRes.data;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      debugPrint(error);
      throw error;
    } catch (exception) {
      rethrow;
    }
  }

  Future<VoteData> getVoteByEpisode({
    required String seasonId,
    required String streamingId,
    required String episodeId,
  }) async {
    try {
      Response res = await _api.dio
          .get('$baseURL/web-app/streaming/vote/get-vote', queryParameters: {
        'streamingID': streamingId,
        'seasonID': seasonId,
        'streamingEpisodesID': episodeId,
      });
      VoteResponse vote = VoteResponse.fromJson(res.data);
      return vote.data;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      debugPrint(error);
      throw error;
    } catch (exception) {
      rethrow;
    }
  }

  Future<List<Comments>> getCommentByEpisode({
    required String streamingId,
    required String episodeId,
  }) async {
    List<Comments> comments = [];
    try {
      Response res = await _api.dio
          .get('$baseURL/web-app/streaming/vote/get-vote', queryParameters: {
        'streamingID': streamingId,
        'streamingEpisodesID': episodeId,
      });
      CommentResponse commentRes = CommentResponse.fromJson(res.data);
      comments = commentRes.data.docs;
      return comments;
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      debugPrint(error);
      throw error;
    } catch (exception) {
      rethrow;
    }
  }
}
