// To parse this JSON data, do
//
//     final commentResponse = commentResponseFromJson(jsonString);

import 'dart:convert';

CommentResponse commentResponseFromJson(String str) =>
    CommentResponse.fromJson(json.decode(str));

String commentResponseToJson(CommentResponse data) =>
    json.encode(data.toJson());

class CommentResponse {
  CommentResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  final bool status;
  final String msg;
  final CommentData data;

  CommentResponse copyWith({
    required bool status,
    required String msg,
    required CommentData data,
  }) =>
      CommentResponse(
        status: status,
        msg: msg,
        data: data,
      );

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        status: json["status"],
        msg: json["msg"],
        data: CommentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class CommentData {
  CommentData({
    required this.limit,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.hasMore,
    required this.docs,
    required this.totalDocs,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
  });

  final int limit;
  final bool hasPrevPage;
  final bool hasNextPage;
  final bool hasMore;
  final List<Comments> docs;
  final int totalDocs;
  final int totalPages;
  final int page;
  final int pagingCounter;

  CommentData copyWith({
    required int limit,
    required bool hasPrevPage,
    required bool hasNextPage,
    required bool hasMore,
    required List<Comments> docs,
    required int totalDocs,
    required int totalPages,
    required int page,
    required int pagingCounter,
  }) =>
      CommentData(
        limit: limit,
        hasPrevPage: hasPrevPage,
        hasNextPage: hasNextPage,
        hasMore: hasMore,
        docs: docs,
        totalDocs: totalDocs,
        totalPages: totalPages,
        page: page,
        pagingCounter: pagingCounter,
      );

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        limit: json["limit"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        hasMore: json["hasMore"],
        docs:
            List<Comments>.from(json["docs"].map((x) => Comments.fromJson(x))),
        totalDocs: json["totalDocs"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "hasMore": hasMore,
        "docs": docs == null
            ? null
            : List<dynamic>.from(docs.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
      };
}

class Comments {
  Comments({
    required this.id,
    required this.status,
    required this.quantityHeart,
    required this.deleted,
    required this.streamingId,
    required this.streamingEpisodesId,
    required this.content,
    required this.userId,
    required this.createdAt,
    required this.isHeart,
  });

  final String id;
  final int status;
  final int quantityHeart;
  final bool deleted;
  final String streamingId;
  final StreamingEpisodesId streamingEpisodesId;
  final String content;
  final UserId userId;
  final DateTime createdAt;
  final bool isHeart;

  Comments copyWith({
    required String id,
    required int status,
    required int quantityHeart,
    required bool deleted,
    required String streamingId,
    required StreamingEpisodesId streamingEpisodesId,
    required String content,
    required UserId userId,
    required DateTime createdAt,
    required bool isHeart,
  }) =>
      Comments(
        id: id,
        status: status,
        quantityHeart: quantityHeart,
        deleted: deleted,
        streamingId: streamingId,
        streamingEpisodesId: streamingEpisodesId,
        content: content,
        userId: userId,
        createdAt: createdAt,
        isHeart: isHeart,
      );

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        id: json["_id"],
        status: json["status"],
        quantityHeart: json["quantityHeart"],
        deleted: json["deleted"],
        streamingId: json["streamingID"],
        streamingEpisodesId:
            StreamingEpisodesId.fromJson(json["streamingEpisodesID"]),
        content: json["content"],
        userId: UserId.fromJson(json["userID"]),
        createdAt: DateTime.parse(json["createdAt"]),
        isHeart: json["isHeart"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "quantityHeart": quantityHeart,
        "deleted": deleted,
        "streamingID": streamingId,
        "streamingEpisodesID": streamingEpisodesId.toJson(),
        "content": content,
        "userID": userId.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "isHeart": isHeart,
      };
}

class StreamingEpisodesId {
  StreamingEpisodesId({
    required this.id,
    required this.storyEpisodeKr,
    required this.storyEpisodeEng,
    required this.number,
  });

  final String id;
  final String storyEpisodeKr;
  final String storyEpisodeEng;
  final int number;

  StreamingEpisodesId copyWith({
    required String id,
    required String storyEpisodeKr,
    required String storyEpisodeEng,
    required int number,
  }) =>
      StreamingEpisodesId(
        id: id,
        storyEpisodeKr: storyEpisodeKr,
        storyEpisodeEng: storyEpisodeEng,
        number: number,
      );

  factory StreamingEpisodesId.fromJson(Map<String, dynamic> json) =>
      StreamingEpisodesId(
        id: json["_id"],
        storyEpisodeKr: json["storyEpisode_kr"],
        storyEpisodeEng: json["storyEpisode_eng"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "storyEpisode_kr": storyEpisodeKr,
        "storyEpisode_eng": storyEpisodeEng,
        "number": number,
      };
}

class UserId {
  UserId({
    required this.id,
    required this.userName,
    required this.avatar,
    required this.userEmail,
  });

  final String id;
  final String userName;
  final String avatar;
  final String userEmail;

  UserId copyWith({
    required String id,
    required String userName,
    required String avatar,
    required String userEmail,
  }) =>
      UserId(
        id: id,
        userName: userName,
        avatar: avatar,
        userEmail: userEmail,
      );

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        userName: json["userName"],
        avatar: json["avatar"],
        userEmail: json["userEmail"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "avatar": avatar,
        "userEmail": userEmail,
      };
}
