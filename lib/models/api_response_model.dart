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

  @override
  List<Object> get props => [status, msg];
}
