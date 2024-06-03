import 'package:equatable/equatable.dart';

class SuccessResponseModel extends Equatable {
  final String message;
  final Map<String, dynamic>? data;

  const SuccessResponseModel({
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
        message,
        data,
      ];

  factory SuccessResponseModel.fromJson(Map<String, dynamic> json) {
    return SuccessResponseModel(
      message: json['message'] ?? "",
      data: json['data'] as Map<String, dynamic>?,
    );
  }
}
