// To parse this JSON data, do
//
//     final episode = episodeFromJson(jsonString);
import 'dart:convert';

EpisodeResponse episodeFromJson(String str) =>
    EpisodeResponse.fromJson(json.decode(str));

String episodeToJson(EpisodeResponse data) => json.encode(data.toJson());

class EpisodeResponse {
  EpisodeResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  final bool status;
  final String msg;
  final List<Episode> data;

  EpisodeResponse copyWith({
    required bool status,
    required String msg,
    required List<Episode> data,
  }) =>
      EpisodeResponse(
        status: status,
        msg: msg,
        data: data,
      );

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) =>
      EpisodeResponse(
        status: json["status"],
        msg: json["msg"],
        data: List<Episode>.from(json["data"].map((x) => Episode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Episode {
  Episode({
    required this.deleted,
    required this.id,
    required this.streamingId,
    required this.seasonId,
    required this.episodesTemplateId,
    required this.seasonTemplateId,
    required this.number,
    required this.numberSeason,
    required this.createdAt,
  });

  final bool deleted;
  final String id;
  final String streamingId;
  final String seasonId;
  final TemplateId episodesTemplateId;
  final TemplateId seasonTemplateId;
  final int number;
  final int numberSeason;
  final DateTime createdAt;

  Episode copyWith({
    required bool deleted,
    required String id,
    required String streamingId,
    required String seasonId,
    required TemplateId episodesTemplateId,
    required TemplateId seasonTemplateId,
    required int number,
    required int numberSeason,
    required DateTime createdAt,
  }) =>
      Episode(
        deleted: deleted,
        id: id,
        streamingId: streamingId,
        seasonId: seasonId,
        episodesTemplateId: episodesTemplateId,
        seasonTemplateId: seasonTemplateId,
        number: number,
        numberSeason: numberSeason,
        createdAt: createdAt,
      );

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        deleted: json["deleted"],
        id: json["_id"],
        streamingId: json["streamingID"],
        seasonId: json["seasonID"],
        episodesTemplateId: TemplateId.fromJson(json["episodesTemplateID"]),
        seasonTemplateId: TemplateId.fromJson(json["seasonTemplateID"]),
        number: json["number"],
        numberSeason: json["numberSeason"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "deleted": deleted,
        "_id": id,
        "streamingID": streamingId,
        "seasonID": seasonId,
        "episodesTemplateID": episodesTemplateId.toJson(),
        "seasonTemplateID": seasonTemplateId.toJson(),
        "number": number,
        "numberSeason": numberSeason,
        "createdAt": createdAt.toIso8601String(),
      };
}

class TemplateId {
  TemplateId({
    required this.id,
    required this.nameKr,
    required this.nameEng,
    required this.number,
  });

  final String id;
  final String nameKr;
  final String nameEng;
  final int number;

  TemplateId copyWith({
    required String id,
    required String nameKr,
    required String nameEng,
    required int number,
  }) =>
      TemplateId(
        id: id,
        nameKr: nameKr,
        nameEng: nameEng,
        number: number,
      );

  factory TemplateId.fromJson(Map<String, dynamic> json) => TemplateId(
        id: json["_id"],
        nameKr: json["name_kr"],
        nameEng: json["name_eng"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name_kr": nameKr,
        "name_eng": nameEng,
        "number": number,
      };
}
