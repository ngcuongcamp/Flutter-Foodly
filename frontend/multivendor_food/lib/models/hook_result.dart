import 'dart:convert';

HookResultModel hookResultModelFromJson(String str) =>
    HookResultModel.fromJson(json.decode(str));

String hookResultModelToJson(HookResultModel data) =>
    json.encode(data.toJson());

class HookResultModel {
  bool status;
  String message;
  dynamic data;

  HookResultModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HookResultModel.fromJson(Map<String, dynamic> json) =>
      HookResultModel(
          status: json["status"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() =>
      {"status": status, "message": message, "data": data};
}
