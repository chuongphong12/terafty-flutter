// To parse this JSON data, do
//
//     final voteResponse = voteResponseFromJson(jsonString);

import 'dart:convert';

VoteResponse voteResponseFromJson(String str) =>
    VoteResponse.fromJson(json.decode(str));

String voteResponseToJson(VoteResponse data) => json.encode(data.toJson());

class VoteResponse {
  VoteResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  final bool status;
  final String msg;
  final VoteData data;

  VoteResponse copyWith({
    required bool status,
    required String msg,
    required VoteData data,
  }) =>
      VoteResponse(
        status: status,
        msg: msg,
        data: data,
      );

  factory VoteResponse.fromJson(Map<String, dynamic> json) => VoteResponse(
        status: json["status"],
        msg: json["msg"],
        data: VoteData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class VoteData {
  VoteData({
    required this.vote,
    required this.voteOption,
    required this.isVote,
  });

  final Vote vote;
  final List<VoteOption> voteOption;
  final bool isVote;

  VoteData copyWith({
    required Vote vote,
    required List<VoteOption> voteOption,
    required bool isVote,
  }) =>
      VoteData(
        vote: vote,
        voteOption: voteOption,
        isVote: isVote,
      );

  factory VoteData.fromJson(Map<String, dynamic> json) => VoteData(
        vote: Vote.fromJson(json["vote"]),
        voteOption: List<VoteOption>.from(
          json["voteOption"].map((x) => VoteOption.fromJson(x)),
        ),
        isVote: json["isVote"],
      );

  Map<String, dynamic> toJson() => {
        "vote": vote.toJson(),
        "voteOption": List<dynamic>.from(voteOption.map((x) => x.toJson())),
        "isVote": isVote,
      };
}

class Vote {
  Vote({
    required this.status,
    required this.quantity,
    required this.deleted,
    required this.id,
    required this.streamingId,
    required this.streamingEpisodesId,
    required this.titleEng,
    required this.titleKr,
    required this.contentEng,
    required this.contentKr,
    required this.method,
    required this.startDate,
    required this.endDate,
  });

  final int status;
  final int quantity;
  final bool deleted;
  final String id;
  final String streamingId;
  final String streamingEpisodesId;
  final String titleEng;
  final String titleKr;
  final String contentEng;
  final String contentKr;
  final Method method;
  final DateTime startDate;
  final DateTime endDate;

  Vote copyWith({
    required int status,
    required int quantity,
    required bool deleted,
    required String id,
    required String streamingId,
    required String streamingEpisodesId,
    required String titleEng,
    required String titleKr,
    required String contentEng,
    required String contentKr,
    required Method method,
    required DateTime startDate,
    required DateTime endDate,
  }) =>
      Vote(
        status: status,
        quantity: quantity,
        deleted: deleted,
        id: id,
        streamingId: streamingId,
        streamingEpisodesId: streamingEpisodesId,
        titleEng: titleEng,
        titleKr: titleKr,
        contentEng: contentEng,
        contentKr: contentKr,
        method: method,
        startDate: startDate,
        endDate: endDate,
      );

  factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        status: json["status"],
        quantity: json["quantity"],
        deleted: json["deleted"],
        id: json["_id"],
        streamingId: json["streamingID"],
        streamingEpisodesId: json["streamingEpisodesID"],
        titleEng: json["title_eng"],
        titleKr: json["title_kr"],
        contentEng: json["content_eng"],
        contentKr: json["content_kr"],
        method: Method.fromJson(json["method"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "quantity": quantity,
        "deleted": deleted,
        "_id": id,
        "streamingID": streamingId,
        "streamingEpisodesID": streamingEpisodesId,
        "title_eng": titleEng,
        "title_kr": titleKr,
        "content_eng": contentEng,
        "content_kr": contentKr,
        "method": method.toJson(),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}

class Method {
  Method({
    required this.id,
    required this.nameKr,
    required this.nameEng,
  });

  final String id;
  final String nameKr;
  final String nameEng;

  Method copyWith({
    required String id,
    required String nameKr,
    required String nameEng,
  }) =>
      Method(
        id: id,
        nameKr: nameKr,
        nameEng: nameEng,
      );

  factory Method.fromJson(Map<String, dynamic> json) => Method(
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

class VoteOption {
  VoteOption({
    required this.id,
    required this.quantity,
    required this.deleted,
    required this.dataEng,
    required this.dataKr,
    required this.image,
    required this.voteId,
    required this.streamingId,
    required this.streamingEpisodesId,
    required this.seasonId,
    required this.isChoosen,
  });

  final String id;
  final int quantity;
  final bool deleted;
  final String dataEng;
  final String dataKr;
  final String image;
  final String voteId;
  final String streamingId;
  final String streamingEpisodesId;
  final String seasonId;
  final bool isChoosen;

  VoteOption copyWith({
    required String id,
    required int quantity,
    required bool deleted,
    required String dataEng,
    required String dataKr,
    required String image,
    required String voteId,
    required String streamingId,
    required String streamingEpisodesId,
    required String seasonId,
    required bool isChoosen,
  }) =>
      VoteOption(
        id: id,
        quantity: quantity,
        deleted: deleted,
        dataEng: dataEng,
        dataKr: dataKr,
        image: image,
        voteId: voteId,
        streamingId: streamingId,
        streamingEpisodesId: streamingEpisodesId,
        seasonId: seasonId,
        isChoosen: isChoosen,
      );

  factory VoteOption.fromJson(Map<String, dynamic> json) => VoteOption(
        id: json["_id"],
        quantity: json["quantity"],
        deleted: json["deleted"],
        dataEng: json["data_eng"],
        dataKr: json["data_kr"],
        image: json["image"],
        voteId: json["voteID"],
        streamingId: json["streamingID"],
        streamingEpisodesId: json["streamingEpisodesID"],
        seasonId: json["seasonID"],
        isChoosen: json["isChoosen"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "quantity": quantity,
        "deleted": deleted,
        "data_eng": dataEng,
        "data_kr": dataKr,
        "image": image,
        "voteID": voteId,
        "streamingID": streamingId,
        "streamingEpisodesID": streamingEpisodesId,
        "seasonID": seasonId,
        "isChoosen": isChoosen,
      };
}
