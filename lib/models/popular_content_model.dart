// To parse this JSON data, do
//
//     final popularContent = popularContentFromJson(jsonString);

import 'dart:convert';

PopularContent popularContentFromJson(String str) =>
    PopularContent.fromJson(json.decode(str));

String popularContentToJson(PopularContent data) => json.encode(data.toJson());

class PopularContent {
  PopularContent({
    required this.status,
    required this.msg,
    required this.data,
  });

  final bool status;
  final String msg;
  final Data data;

  PopularContent copyWith({
    required bool status,
    required String msg,
    required Data data,
  }) =>
      PopularContent(
        status: status,
        msg: msg,
        data: data,
      );

  factory PopularContent.fromJson(Map<String, dynamic> json) => PopularContent(
        status: json["status"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.limit,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.hasMore,
    required this.docs,
    required this.totalDocs,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.nextPage,
  });

  final int limit;
  final bool hasPrevPage;
  final bool hasNextPage;
  final bool hasMore;
  final List<Doc> docs;
  final int totalDocs;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final int nextPage;

  Data copyWith({
    required int limit,
    required bool hasPrevPage,
    required bool hasNextPage,
    required bool hasMore,
    required List<Doc> docs,
    required int totalDocs,
    required int totalPages,
    required int page,
    required int pagingCounter,
    required int nextPage,
  }) =>
      Data(
        limit: limit,
        hasPrevPage: hasPrevPage,
        hasNextPage: hasNextPage,
        hasMore: hasMore,
        docs: docs,
        totalDocs: totalDocs,
        totalPages: totalPages,
        page: page,
        pagingCounter: pagingCounter,
        nextPage: nextPage,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        limit: json["limit"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        hasMore: json["hasMore"],
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
        totalDocs: json["totalDocs"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "hasMore": hasMore,
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "nextPage": nextPage,
      };
}

class Doc {
  Doc({
    required this.id,
    this.streamingId,
    this.crowdfundingId,
    required this.v,
    required this.createdAt,
    required this.createdBy,
    required this.imageMobileDomestic,
    required this.imageMobileOversea,
    required this.imageWebDomestic,
    required this.imageWebOversea,
    required this.position,
    required this.titleEng,
    required this.titleKr,
    required this.type,
    required this.updatedAt,
  });

  final String id;
  final String? streamingId;
  final CrowdfundingId? crowdfundingId;
  final int v;
  final DateTime createdAt;
  final String createdBy;
  final String imageMobileDomestic;
  final String imageMobileOversea;
  final String imageWebDomestic;
  final String imageWebOversea;
  final int position;
  final String titleEng;
  final String titleKr;
  final String type;
  final DateTime updatedAt;

  Doc copyWith({
    required String id,
    String? streamingId,
    CrowdfundingId? crowdfundingId,
    required int v,
    required DateTime createdAt,
    required String createdBy,
    required String imageMobileDomestic,
    required String imageMobileOversea,
    required String imageWebDomestic,
    required String imageWebOversea,
    required int position,
    required String titleEng,
    required String titleKr,
    required String type,
    required DateTime updatedAt,
  }) =>
      Doc(
        id: id,
        streamingId: streamingId ?? this.streamingId,
        crowdfundingId: crowdfundingId ?? this.crowdfundingId,
        v: v,
        createdAt: createdAt,
        createdBy: createdBy,
        imageMobileDomestic: imageMobileDomestic,
        imageMobileOversea: imageMobileOversea,
        imageWebDomestic: imageWebDomestic,
        imageWebOversea: imageWebOversea,
        position: position,
        titleEng: titleEng,
        titleKr: titleKr,
        type: type,
        updatedAt: updatedAt,
      );

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        streamingId: json["streamingID"],
        crowdfundingId: json["crowdfundingID"] == null
            ? null
            : CrowdfundingId.fromJson(json["crowdfundingID"]),
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        imageMobileDomestic: json["imageMobileDomestic"],
        imageMobileOversea: json["imageMobileOversea"],
        imageWebDomestic: json["imageWebDomestic"],
        imageWebOversea: json["imageWebOversea"],
        position: json["position"],
        titleEng: json["title_eng"],
        titleKr: json["title_kr"],
        type: json["type"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "streamingID": streamingId,
        "crowdfundingID": crowdfundingId?.toJson(),
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "imageMobileDomestic": imageMobileDomestic,
        "imageMobileOversea": imageMobileOversea,
        "imageWebDomestic": imageWebDomestic,
        "imageWebOversea": imageWebOversea,
        "position": position,
        "title_eng": titleEng,
        "title_kr": titleKr,
        "type": type,
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class CrowdfundingId {
  CrowdfundingId({
    required this.id,
    required this.amount,
    required this.url,
  });

  final String id;
  final int amount;
  final String url;

  CrowdfundingId copyWith({
    required String id,
    required int amount,
    required String url,
  }) =>
      CrowdfundingId(
        id: id,
        amount: amount,
        url: url,
      );

  factory CrowdfundingId.fromJson(Map<String, dynamic> json) => CrowdfundingId(
        id: json["_id"],
        amount: json["amount"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "url": url,
      };
}
