// To parse this JSON data, do
//
//     final streamDetail = streamDetailFromJson(jsonString);

import 'dart:convert';

StreamDetailResponse streamDetailFromJson(String str) =>
    StreamDetailResponse.fromJson(json.decode(str));

String streamDetailToJson(StreamDetailResponse data) =>
    json.encode(data.toJson());

class StreamDetailResponse {
  StreamDetailResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  final bool status;
  final String msg;
  final StreamDetail data;

  StreamDetailResponse copyWith({
    required bool status,
    required String msg,
    required StreamDetail data,
  }) =>
      StreamDetailResponse(
        status: status,
        msg: msg,
        data: data,
      );

  factory StreamDetailResponse.fromJson(Map<String, dynamic> json) =>
      StreamDetailResponse(
        status: json["status"],
        msg: json["msg"],
        data: StreamDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class StreamDetail {
  StreamDetail({
    required this.status,
    required this.view,
    required this.quantityEpisodes,
    required this.quantityClick,
    required this.quantityVote,
    required this.deleted,
    required this.id,
    required this.seasonTemplateId,
    required this.storyKr,
    required this.storyEng,
    required this.productInformation,
    required this.programParticipants,
    required this.streamingId,
    required this.createdAt,
    required this.number,
  });

  final int status;
  final int view;
  final int quantityEpisodes;
  final int quantityClick;
  final int quantityVote;
  final bool deleted;
  final String id;
  final SeasonTemplateId seasonTemplateId;
  final String storyKr;
  final String storyEng;
  final List<ProductInformation> productInformation;
  final List<ProgramParticipant> programParticipants;
  final String streamingId;
  final DateTime createdAt;
  final int number;

  StreamDetail copyWith({
    required int status,
    required int view,
    required int quantityEpisodes,
    required int quantityClick,
    required int quantityVote,
    required bool deleted,
    required String id,
    required SeasonTemplateId seasonTemplateId,
    required String storyKr,
    required String storyEng,
    required List<ProductInformation> productInformation,
    required List<ProgramParticipant> programParticipants,
    required String streamingId,
    required DateTime createdAt,
    required int number,
  }) =>
      StreamDetail(
        status: status,
        view: view,
        quantityEpisodes: quantityEpisodes,
        quantityClick: quantityClick,
        quantityVote: quantityVote,
        deleted: deleted,
        id: id,
        seasonTemplateId: seasonTemplateId,
        storyKr: storyKr,
        storyEng: storyEng,
        productInformation: productInformation,
        programParticipants: programParticipants,
        streamingId: streamingId,
        createdAt: createdAt,
        number: number,
      );

  factory StreamDetail.fromJson(Map<String, dynamic> json) => StreamDetail(
        status: json["status"],
        view: json["view"],
        quantityEpisodes: json["quantityEpisodes"],
        quantityClick: json["quantityClick"],
        quantityVote: json["quantityVote"],
        deleted: json["deleted"],
        id: json["_id"],
        seasonTemplateId: SeasonTemplateId.fromJson(json["seasonTemplateID"]),
        storyKr: json["story_kr"],
        storyEng: json["story_eng"],
        productInformation: List<ProductInformation>.from(
            json["productInformation"]
                .map((x) => ProductInformation.fromJson(x))),
        programParticipants: List<ProgramParticipant>.from(
            json["programParticipants"]
                .map((x) => ProgramParticipant.fromJson(x))),
        streamingId: json["streamingID"],
        createdAt: DateTime.parse(json["createdAt"]),
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "view": view,
        "quantityEpisodes": quantityEpisodes,
        "quantityClick": quantityClick,
        "quantityVote": quantityVote,
        "deleted": deleted,
        "_id": id,
        "seasonTemplateID": seasonTemplateId.toJson(),
        "story_kr": storyKr,
        "story_eng": storyEng,
        "productInformation":
            List<dynamic>.from(productInformation.map((x) => x.toJson())),
        "programParticipants":
            List<dynamic>.from(programParticipants.map((x) => x.toJson())),
        "streamingID": streamingId,
        "createdAt": createdAt.toIso8601String(),
        "number": number,
      };
}

class ProductInformation {
  ProductInformation({
    required this.id,
    required this.nameKr,
    required this.dataKr,
    required this.nameEng,
    required this.dataEng,
  });

  final String id;
  final String nameKr;
  final String dataKr;
  final String nameEng;
  final String dataEng;

  ProductInformation copyWith({
    required String id,
    required String nameKr,
    required String dataKr,
    required String nameEng,
    required String dataEng,
  }) =>
      ProductInformation(
        id: id,
        nameKr: nameKr,
        dataKr: dataKr,
        nameEng: nameEng,
        dataEng: dataEng,
      );

  factory ProductInformation.fromJson(Map<String, dynamic> json) =>
      ProductInformation(
        id: json["_id"],
        nameKr: json["name_kr"],
        dataKr: json["data_kr"],
        nameEng: json["name_eng"],
        dataEng: json["data_eng"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name_kr": nameKr,
        "data_kr": dataKr,
        "name_eng": nameEng,
        "data_eng": dataEng,
      };
}

class ProgramParticipant {
  ProgramParticipant({
    required this.id,
    required this.dataNameCharacterKr,
    required this.dataNameCharacterEng,
    required this.dataNameActorKr,
    required this.dataNameActorEng,
    required this.avatar,
  });

  final String id;
  final String dataNameCharacterKr;
  final String dataNameCharacterEng;
  final String dataNameActorKr;
  final String dataNameActorEng;
  final String avatar;

  ProgramParticipant copyWith({
    required String id,
    required String dataNameCharacterKr,
    required String dataNameCharacterEng,
    required String dataNameActorKr,
    required String dataNameActorEng,
    required String avatar,
  }) =>
      ProgramParticipant(
        id: id,
        dataNameCharacterKr: dataNameCharacterKr,
        dataNameCharacterEng: dataNameCharacterEng,
        dataNameActorKr: dataNameActorKr,
        dataNameActorEng: dataNameActorEng,
        avatar: avatar,
      );

  factory ProgramParticipant.fromJson(Map<String, dynamic> json) =>
      ProgramParticipant(
        id: json["_id"],
        dataNameCharacterKr: json["dataNameCharacter_kr"],
        dataNameCharacterEng: json["dataNameCharacter_eng"],
        dataNameActorKr: json["dataNameActor_kr"],
        dataNameActorEng: json["dataNameActor_eng"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "dataNameCharacter_kr": dataNameCharacterKr,
        "dataNameCharacter_eng": dataNameCharacterEng,
        "dataNameActor_kr": dataNameActorKr,
        "dataNameActor_eng": dataNameActorEng,
        "avatar": avatar,
      };
}

class SeasonTemplateId {
  SeasonTemplateId({
    required this.id,
    required this.nameKr,
    required this.nameEng,
    required this.number,
  });

  final String id;
  final String nameKr;
  final String nameEng;
  final int number;

  SeasonTemplateId copyWith({
    required String id,
    required String nameKr,
    required String nameEng,
    required int number,
  }) =>
      SeasonTemplateId(
        id: id,
        nameKr: nameKr,
        nameEng: nameEng,
        number: number,
      );

  factory SeasonTemplateId.fromJson(Map<String, dynamic> json) =>
      SeasonTemplateId(
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
