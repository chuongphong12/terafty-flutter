// To parse this JSON data, do
//
//     final episode = episodeFromJson(jsonString);

import 'dart:convert';

EpisodeResponse episodeFromJson(String str) => EpisodeResponse.fromJson(json.decode(str));

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

    factory EpisodeResponse.fromJson(Map<String, dynamic> json) => EpisodeResponse(
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
        required this.view,
        required this.deleted,
        required this.id,
        required this.streamingId,
        required this.seasonId,
        required this.thumbnailImageOverseaEpisodes,
        required this.thumbnailImageDomesticEpisodes,
        required this.storyEpisodeKr,
        required this.storyEpisodeEng,
        required this.url,
        required this.episodesTemplateId,
        required this.seasonTemplateId,
        required this.numberSeason,
        required this.number,
        required this.createdAt,
    });

    final int view;
    final bool deleted;
    final String id;
    final String streamingId;
    final String seasonId;
    final String thumbnailImageOverseaEpisodes;
    final String thumbnailImageDomesticEpisodes;
    final String storyEpisodeKr;
    final String storyEpisodeEng;
    final String url;
    final TemplateId episodesTemplateId;
    final TemplateId seasonTemplateId;
    final int numberSeason;
    final int number;
    final DateTime createdAt;

    Episode copyWith({
        required int view,
        required bool deleted,
        required String id,
        required String streamingId,
        required String seasonId,
        required String thumbnailImageOverseaEpisodes,
        required String thumbnailImageDomesticEpisodes,
        required String storyEpisodeKr,
        required String storyEpisodeEng,
        required String url,
        required TemplateId episodesTemplateId,
        required TemplateId seasonTemplateId,
        required int numberSeason,
        required int number,
        required DateTime createdAt,
    }) => 
        Episode(
            view: view,
            deleted: deleted,
            id: id,
            streamingId: streamingId,
            seasonId: seasonId,
            thumbnailImageOverseaEpisodes: thumbnailImageOverseaEpisodes,
            thumbnailImageDomesticEpisodes: thumbnailImageDomesticEpisodes,
            storyEpisodeKr: storyEpisodeKr,
            storyEpisodeEng: storyEpisodeEng,
            url: url,
            episodesTemplateId: episodesTemplateId,
            seasonTemplateId: seasonTemplateId,
            numberSeason: numberSeason,
            number: number,
            createdAt: createdAt,
        );

    factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        view: json["view"],
        deleted: json["deleted"],
        id: json["_id"],
        streamingId: json["streamingID"],
        seasonId: json["seasonID"],
        thumbnailImageOverseaEpisodes: json["thumbnailImageOverseaEpisodes"],
        thumbnailImageDomesticEpisodes: json["thumbnailImageDomesticEpisodes"],
        storyEpisodeKr: json["storyEpisode_kr"],
        storyEpisodeEng: json["storyEpisode_eng"],
        url: json["url"],
        episodesTemplateId: TemplateId.fromJson(json["episodesTemplateID"]),
        seasonTemplateId: TemplateId.fromJson(json["seasonTemplateID"]),
        numberSeason: json["numberSeason"],
        number: json["number"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "view": view,
        "deleted": deleted,
        "_id": id,
        "streamingID": streamingId,
        "seasonID": seasonId,
        "thumbnailImageOverseaEpisodes": thumbnailImageOverseaEpisodes,
        "thumbnailImageDomesticEpisodes": thumbnailImageDomesticEpisodes,
        "storyEpisode_kr": storyEpisodeKr,
        "storyEpisode_eng": storyEpisodeEng,
        "url": url,
        "episodesTemplateID": episodesTemplateId.toJson(),
        "seasonTemplateID": seasonTemplateId.toJson(),
        "numberSeason": numberSeason,
        "number": number,
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
