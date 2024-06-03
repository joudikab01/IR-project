class ErrorResponseModel {
  String? message;

  ErrorResponseModel({this.message});

  static ErrorResponseModel fromJson(Map<String, dynamic> json) {
    final errorMessages = <ErrorResponseModel>[];
    json.forEach((key, value) {
      if (key == "errors" && value is Map) {
        Map<String, dynamic> map = Map<String, dynamic>.from(json[key]);
        map.forEach((mapKey, value) {
          errorMessages.add(ErrorResponseModel(message: map[mapKey][0]));
        });
      }
    });

    return errorMessages.isNotEmpty
        ? errorMessages.first
        : ErrorResponseModel(message: json['message']);
  }
}
