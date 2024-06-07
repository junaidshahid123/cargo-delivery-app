// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromMap(jsonString);

import 'dart:convert';

DashBoardModel dashBoardModelFromMap(String str) =>
    DashBoardModel.fromMap(json.decode(str));

String dashBoardModelToMap(DashBoardModel data) => json.encode(data.toMap());

class DashBoardModel {
  String status;
  List<Category> categories;
  String imageBaseUrl;
  List<dynamic> currentRides;

  DashBoardModel({
    required this.status,
    required this.categories,
    required this.imageBaseUrl,
    required this.currentRides,
  });

  factory DashBoardModel.fromMap(Map<String, dynamic> json) => DashBoardModel(
        status: json["status"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromMap(x))),
        imageBaseUrl: json["image_base_url"],
        currentRides: List<dynamic>.from(json["currentRides"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
        "image_base_url": imageBaseUrl,
        "currentRides": List<dynamic>.from(currentRides.map((x) => x)),
      };
}

class Category {
  String id;
  String name;
  dynamic nameAr;
  String image;
  String status;
  String? description;
  String createdBy;
  String adminChoice;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.image,
    required this.status,
    required this.description,
    required this.createdBy,
    required this.adminChoice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        nameAr: json["name_ar"],
        image: json["image"],
        status: json["status"],
        description: json["description"],
        createdBy: json["created_by"],
        adminChoice: json["admin_choice"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "name_ar": nameAr,
        "image": image,
        "status": status,
        "description": description,
        "created_by": createdBy,
        "admin_choice": adminChoice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
