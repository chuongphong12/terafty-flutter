import 'dart:convert';

import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final bool status;
  final String msg;
  final T data;

  const ApiResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  ApiResponse<T> copyWith({
    bool? status,
    String? msg,
    T? data,
  }) {
    return ApiResponse<T>(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'msg': msg});
    result.addAll({'data': data});

    return result;
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse<T>(
      status: map['status'] ?? false,
      msg: map['msg'] ?? '',
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) =>
      ApiResponse.fromMap(json.decode(source));

  @override
  String toString() => 'ApiResponse(status: $status, msg: $msg, data: $data)';

  @override
  List<Object> get props => [status, msg];
}
