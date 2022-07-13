// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.status,
    required this.msg,
    required this.data,
  });

  final bool status;
  final String msg;
  final Data data;

  User copyWith({
    required bool status,
    required String msg,
    required Data data,
  }) =>
      User(
        status: status,
        msg: msg,
        data: data,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    required this.userName,
    required this.isEmailVerified,
    required this.userRole,
    required this.userGender,
    required this.userDob,
    required this.avatar,
    required this.isLoginKaKao,
    required this.isLoginGoogle,
    required this.deleted,
    required this.deletedAt,
    required this.language,
    required this.status,
    required this.survey,
    required this.id,
    required this.userEmail,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.nation,
    required this.userPhoneNumber,
    required this.typeToken,
    required this.token,
  });

  final String userName;
  final bool isEmailVerified;
  final int userRole;
  final String userGender;
  final DateTime userDob;
  final String avatar;
  final bool isLoginKaKao;
  final bool isLoginGoogle;
  final bool deleted;
  final dynamic deletedAt;
  final String language;
  final int status;
  final List<String> survey;
  final String id;
  final String userEmail;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final String nation;
  final String userPhoneNumber;
  final String typeToken;
  final String token;

  Data copyWith({
    required String userName,
    required bool isEmailVerified,
    required int userRole,
    required String userGender,
    required DateTime userDob,
    required String avatar,
    required bool isLoginKaKao,
    required bool isLoginGoogle,
    required bool deleted,
    required dynamic deletedAt,
    required String language,
    required int status,
    required List<String> survey,
    required String id,
    required String userEmail,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int userId,
    required String nation,
    required String userPhoneNumber,
    required String typeToken,
    required String token,
  }) =>
      Data(
        userName: userName,
        isEmailVerified: isEmailVerified,
        userRole: userRole,
        userGender: userGender,
        userDob: userDob,
        avatar: avatar,
        isLoginKaKao: isLoginKaKao,
        isLoginGoogle: isLoginGoogle,
        deleted: deleted,
        deletedAt: deletedAt ?? this.deletedAt,
        language: language,
        status: status,
        survey: survey,
        id: id,
        userEmail: userEmail,
        createdAt: createdAt,
        updatedAt: updatedAt,
        userId: userId,
        nation: nation,
        userPhoneNumber: userPhoneNumber,
        typeToken: typeToken,
        token: token,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userName: json["userName"],
        isEmailVerified: json["isEmailVerified"],
        userRole: json["userRole"],
        userGender: json["userGender"],
        userDob: DateTime.parse(json["userDOB"]),
        avatar: json["avatar"],
        isLoginKaKao: json["isLoginKaKao"],
        isLoginGoogle: json["isLoginGoogle"],
        deleted: json["deleted"],
        deletedAt: json["deletedAt"],
        language: json["language"],
        status: json["status"],
        survey: List<String>.from(json["survey"].map((x) => x)),
        id: json["_id"],
        userEmail: json["userEmail"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userID"],
        nation: json["nation"],
        userPhoneNumber: json["userPhoneNumber"],
        typeToken: json["typeToken"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "isEmailVerified": isEmailVerified,
        "userRole": userRole,
        "userGender": userGender,
        "userDOB": userDob.toIso8601String(),
        "avatar": avatar,
        "isLoginKaKao": isLoginKaKao,
        "isLoginGoogle": isLoginGoogle,
        "deleted": deleted,
        "deletedAt": deletedAt,
        "language": language,
        "status": status,
        "survey": List<dynamic>.from(survey.map((x) => x)),
        "_id": id,
        "userEmail": userEmail,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userID": userId,
        "nation": nation,
        "userPhoneNumber": userPhoneNumber,
        "typeToken": typeToken,
        "token": token,
      };
}
