// To parse this JSON data, do
//
//     final streaming = streamingFromJson(jsonString);

import 'dart:convert';

Streaming streamingFromJson(String str) => Streaming.fromJson(json.decode(str));

String streamingToJson(Streaming data) => json.encode(data.toJson());

class Streaming {
  Streaming({
    required this.status,
    required this.msg,
    required this.data,
  });

  final bool status;
  final String msg;
  final StreamingData data;

  Streaming copyWith({
    required bool status,
    required String msg,
    required StreamingData data,
  }) =>
      Streaming(
        status: status,
        msg: msg,
        data: data,
      );

  factory Streaming.fromJson(Map<String, dynamic> json) => Streaming(
        status: json["status"],
        msg: json["msg"],
        data: StreamingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class StreamingData {
  StreamingData({
    required this.status,
    required this.view,
    required this.quantityEpisodes,
    required this.quantitySeason,
    required this.bookmark,
    required this.like,
    required this.deleted,
    required this.id,
    required this.representativeImageMobileOversea,
    required this.representativeImageWebOversea,
    required this.representativeImageMobileDomestic,
    required this.representativeImageWebDomestic,
    required this.titleKr,
    required this.titleEng,
    required this.storyKr,
    required this.storyEng,
    required this.videoRank,
    required this.category,
    required this.categoryGenre,
    required this.createdAt,
    required this.updatedAt,
    required this.streamingId,
    required this.isLike,
    required this.isBookmark,
  });

  final int status;
  final int view;
  final int quantityEpisodes;
  final int quantitySeason;
  final int bookmark;
  final int like;
  final bool deleted;
  final String id;
  final String representativeImageMobileOversea;
  final String representativeImageWebOversea;
  final String representativeImageMobileDomestic;
  final String representativeImageWebDomestic;
  final String titleKr;
  final String titleEng;
  final String storyKr;
  final String storyEng;
  final Category videoRank;
  final Category category;
  final Category categoryGenre;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int streamingId;
  final bool isLike;
  final bool isBookmark;

  StreamingData copyWith({
    required int status,
    required int view,
    required int quantityEpisodes,
    required int quantitySeason,
    required int bookmark,
    required int like,
    required bool deleted,
    required String id,
    required String representativeImageMobileOversea,
    required String representativeImageWebOversea,
    required String representativeImageMobileDomestic,
    required String representativeImageWebDomestic,
    required String titleKr,
    required String titleEng,
    required String storyKr,
    required String storyEng,
    required Category videoRank,
    required Category category,
    required Category categoryGenre,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int streamingId,
    required bool isLike,
    required bool isBookmark,
  }) =>
      StreamingData(
        status: status,
        view: view,
        quantityEpisodes: quantityEpisodes,
        quantitySeason: quantitySeason,
        bookmark: bookmark,
        like: like,
        deleted: deleted,
        id: id,
        representativeImageMobileOversea: representativeImageMobileOversea,
        representativeImageWebOversea: representativeImageWebOversea,
        representativeImageMobileDomestic: representativeImageMobileDomestic,
        representativeImageWebDomestic: representativeImageWebDomestic,
        titleKr: titleKr,
        titleEng: titleEng,
        storyKr: storyKr,
        storyEng: storyEng,
        videoRank: videoRank,
        category: category,
        categoryGenre: categoryGenre,
        createdAt: createdAt,
        updatedAt: updatedAt,
        streamingId: streamingId,
        isLike: isLike,
        isBookmark: isBookmark,
      );

  factory StreamingData.fromJson(Map<String, dynamic> json) => StreamingData(
        status: json["status"],
        view: json["view"],
        quantityEpisodes: json["quantityEpisodes"],
        quantitySeason: json["quantitySeason"],
        bookmark: json["bookmark"],
        like: json["like"],
        deleted: json["deleted"],
        id: json["_id"],
        representativeImageMobileOversea: json["representativeImageMobileOversea"],
        representativeImageWebOversea: json["representativeImageWebOversea"],
        representativeImageMobileDomestic: json["representativeImageMobileDomestic"],
        representativeImageWebDomestic: json["representativeImageWebDomestic"],
        titleKr: json["title_kr"],
        titleEng: json["title_eng"],
        storyKr: json["story_kr"],
        storyEng: json["story_eng"],
        videoRank: Category.fromJson(json["videoRank"]),
        category: Category.fromJson(json["category"]),
        categoryGenre: Category.fromJson(json["categoryGenre"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        streamingId: json["streamingID"],
        isLike: json["isLike"],
        isBookmark: json["isBookmark"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "view": view,
        "quantityEpisodes": quantityEpisodes,
        "quantitySeason": quantitySeason,
        "bookmark": bookmark,
        "like": like,
        "deleted": deleted,
        "_id": id,
        "representativeImageMobileOversea": representativeImageMobileOversea,
        "representativeImageWebOversea": representativeImageWebOversea,
        "representativeImageMobileDomestic": representativeImageMobileDomestic,
        "representativeImageWebDomestic": representativeImageWebDomestic,
        "title_kr": titleKr,
        "title_eng": titleEng,
        "story_kr": storyKr,
        "story_eng": storyEng,
        "videoRank": videoRank.toJson(),
        "category": category.toJson(),
        "categoryGenre": categoryGenre.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "streamingID": streamingId,
        "isLike": isLike,
        "isBookmark": isBookmark,
      };
}

class Category {
  Category({
    required this.id,
    required this.nameKr,
    required this.nameEng,
  });

  final String id;
  final String nameKr;
  final String nameEng;

  Category copyWith({
    required String id,
    required String nameKr,
    required String nameEng,
  }) =>
      Category(
        id: id,
        nameKr: nameKr,
        nameEng: nameEng,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        nameKr: json["name_kr"],
        nameEng: json["name_eng"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name_kr": nameKr,
        "name_eng": nameEng,
      };
}
