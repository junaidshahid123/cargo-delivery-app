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
  List<CurrentRides> currentRides;

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
    currentRides: List<CurrentRides>.from(
        json["currentRides"].map((x) => CurrentRides.fromJson(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
    "image_base_url": imageBaseUrl,
    "currentRides": List<dynamic>.from(currentRides.map((x) => x.toMap())),
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


class CurrentRides {
  int id;
  String requestId;
  String amount;
  String userId;
  String isAccept;
  DateTime createdAt;
  DateTime updatedAt;
  Data data;
  Request request;
  User user;

  CurrentRides({
    required this.id,
    required this.requestId,
    required this.amount,
    required this.userId,
    required this.isAccept,
    required this.createdAt,
    required this.updatedAt,
    required this.data,
    required this.request,
    required this.user,
  });

  factory CurrentRides.fromJson(Map<String, dynamic> json) {
    return CurrentRides(
      id: json['id'],
      requestId: json['request_id'],
      amount: json['amount'],
      userId: json['user_id'],
      isAccept: json['is_accept'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      data: Data.fromJson(json['data']),
      request: Request.fromJson(json['request']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "request_id": requestId,
    "amount": amount,
    "user_id": userId,
    "is_accept": isAccept,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "data": data,
    "request": request,
    "user": user,
  };
}


class Data {
  Headers headers;
  Original original;
  dynamic exception;

  Data({
    required this.headers,
    required this.original,
    this.exception,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      headers: Headers.fromJson(json['headers']),
      original: Original.fromJson(json['original']),
      exception: json['exception'],
    );
  }
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) {
    return Headers();
  }
}

class Original {
  double distance;
  double duration;
  DateTime arrivalTime;

  Original({
    required this.distance,
    required this.duration,
    required this.arrivalTime,
  });

  factory Original.fromJson(Map<String, dynamic> json) {
    return Original(
      distance: json['distance'].toDouble(),
      duration: json['duration'].toDouble(),
      arrivalTime: DateTime.parse(json['arrival_time']),
    );
  }
}

class Request {
  int id;
  String userId;
  String parcelLat;
  String parcelLong;
  String parcelAddress;
  String receiverLat;
  String receiverLong;
  String receiverAddress;

  Request({
    required this.id,
    required this.userId,
    required this.parcelLat,
    required this.parcelLong,
    required this.parcelAddress,
    required this.receiverLat,
    required this.receiverLong,
    required this.receiverAddress,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      userId: json['user_id'],
      parcelLat: json['parcel_lat'],
      parcelLong: json['parcel_long'],
      parcelAddress: json['parcel_address'],
      receiverLat: json['receiver_lat'],
      receiverLong: json['receiver_long'],
      receiverAddress: json['receiver_address'],
    );
  }
}

class User {
  int id;
  String name;
  String email;
  String mobile;
  String latitude;
  String longitude;
  String streetAddress;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.latitude,
    required this.longitude,
    required this.streetAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      streetAddress: json['street_address'],
    );
  }
}

