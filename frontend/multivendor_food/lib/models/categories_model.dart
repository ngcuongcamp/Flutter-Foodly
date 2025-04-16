import 'dart:convert';

List<CategoriesModel> categoriesModelFromJson(List<dynamic> list) =>
    list.map((x) => CategoriesModel.fromJson(x)).toList();

// List<CategoriesModel> categoriesModelFromJson(String str) =>
//     List<CategoriesModel>.from(
//         json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String categoriesModelToJson(List<CategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel {
  String id;
  String title;
  String value;
  String imageUrl;

  CategoriesModel({
    required this.id,
    required this.title,
    required this.value,
    required this.imageUrl,
  });

  // factory: convert JSON (Map type) thành một object CategoriesModel
  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["_id"],
        title: json["title"],
        value: json["value"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "value": value,
        "imageUrl": imageUrl,
      };
}
