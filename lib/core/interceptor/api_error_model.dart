import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class APIError {
  final String? code;
  final String? message;

  APIError({this.code, this.message});

  factory APIError.fromJson(Map<String, dynamic>? json) {
    return APIError(
      code: json?['code']?.toString(),
      message: json?['message'] as String?,
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}
