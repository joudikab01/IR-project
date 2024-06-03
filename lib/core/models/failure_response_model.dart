import 'package:equatable/equatable.dart';

class FailureResponseModel extends Equatable {
  final String message;

  const FailureResponseModel({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];

  factory FailureResponseModel.fromJson(Map<String, dynamic> json) {
    return FailureResponseModel(
      message: json['message'] as String,
    );
  }
}
