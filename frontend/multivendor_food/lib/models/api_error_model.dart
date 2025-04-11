import 'dart:convert';

ApiErrorModel apiErrorModelFromJson(String str) =>
    ApiErrorModel.fromJson(json.decode(str));

String apiErrorModelToJson(ApiErrorModel data) => json.encode(data.toJson());

class ApiErrorModel {
  bool status;
  String message;

  ApiErrorModel({
    required this.status,
    required this.message,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
