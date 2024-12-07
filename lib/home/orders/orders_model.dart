class ResponseModel {
  int? status;
  List<AllRide>? allRides;

  ResponseModel({this.status, this.allRides});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      allRides: (json['allRides'] as List?)
          ?.map((ride) => AllRide.fromJson(ride))
          .toList(),
    );
  }
}

class AllRide {
  int? id;
  int? requestId;
  double? amount;
  int? userId;
  bool? isAccept;
  bool? isReject;
  DateTime? createdAt;
  DateTime? updatedAt;
  RideData? data;
  Request? request;
  User? user;

  AllRide({
    this.id,
    this.requestId,
    this.amount,
    this.userId,
    this.isAccept,
    this.isReject,
    this.createdAt,
    this.updatedAt,
    this.data,
    this.request,
    this.user,
  });

  factory AllRide.fromJson(Map<String, dynamic> json) {
    return AllRide(
      id: _parseInt(json['id']),
      requestId: _parseInt(json['request_id']),
      amount: json['amount'] != null ? double.tryParse(json['amount'].toString()) : null,
      userId: _parseInt(json['user_id']),
      isAccept: json['is_accept'] == '1',
      isReject: json['is_reject'] == '0',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      data: json['data'] != null ? RideData.fromJson(json['data']) : null,
      request: json['request'] != null ? Request.fromJson(json['request']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class RideData {
  Map<String, dynamic>? headers;
  RideOriginal? original;
  dynamic exception;

  RideData({
    this.headers,
    this.original,
    this.exception,
  });

  factory RideData.fromJson(Map<String, dynamic> json) {
    return RideData(
      headers: json['headers'] ?? {},
      original: json['original'] != null ? RideOriginal.fromJson(json['original']) : null,
      exception: json['exception'],
    );
  }
}

class RideOriginal {
  double? distance;
  double? duration;
  DateTime? arrivalTime;

  RideOriginal({
    this.distance,
    this.duration,
    this.arrivalTime,
  });

  factory RideOriginal.fromJson(Map<String, dynamic> json) {
    return RideOriginal(
      distance: json['distance'],
      duration: json['duration'],
      arrivalTime: json['arrival_time'] != null ? DateTime.parse(json['arrival_time']) : null,
    );
  }
}

class Request {
  int? id;
  int? userId;
  DateTime? fromDate;
  DateTime? toDate;
  List<String>? images;
  double? parcelLat;
  double? parcelLong;
  String? parcelAddress;
  double? receiverLat;
  double? receiverLong;
  String? receiverAddress;
  String? receiverMobile;
  int? status;
  int? paymentStatus;
  double? amount;
  String? invoiceId;
  int? offerId;
  String? channelName;
  int? categoryId;
  String? code;
  int? paymentMethod;
  DateTime? createdAt;
  DateTime? updatedAt;

  Request({
    this.id,
    this.userId,
    this.fromDate,
    this.toDate,
    this.images,
    this.parcelLat,
    this.parcelLong,
    this.parcelAddress,
    this.receiverLat,
    this.receiverLong,
    this.receiverAddress,
    this.receiverMobile,
    this.status,
    this.paymentStatus,
    this.amount,
    this.invoiceId,
    this.offerId,
    this.channelName,
    this.categoryId,
    this.code,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: _parseInt(json['id']),
      userId: _parseInt(json['user_id']),
      fromDate: json['from_date'] != null ? DateTime.parse(json['from_date']) : null,
      toDate: json['to_date'] != null ? DateTime.parse(json['to_date']) : null,
      images: (json['images'] is List) ? List<String>.from(json['images']) : [json['images'].toString()],
      parcelLat: json['parcel_lat'] != null ? double.tryParse(json['parcel_lat'].toString()) : null,
      parcelLong: json['parcel_long'] != null ? double.tryParse(json['parcel_long'].toString()) : null,
      parcelAddress: json['parcel_address'],
      receiverLat: json['receiver_lat'] != null ? double.tryParse(json['receiver_lat'].toString()) : null,
      receiverLong: json['receiver_long'] != null ? double.tryParse(json['receiver_long'].toString()) : null,
      receiverAddress: json['receiver_address'],
      receiverMobile: json['receiver_mobile'],
      status: _parseInt(json['status']),
      paymentStatus: _parseInt(json['payment_status']),
      amount: json['amount'] != null ? double.tryParse(json['amount'].toString()) : null,
      invoiceId: json['invoice_id'],
      offerId: _parseInt(json['offer_id']),
      channelName: json['channel_name'],
      categoryId: _parseInt(json['category_id']),
      code: json['code'],
      paymentMethod: _parseInt(json['payment_method']),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  double? latitude;
  double? longitude;
  String? streetAddress;

  User({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.latitude,
    this.longitude,
    this.streetAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: _parseInt(json['id']),
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      latitude: json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null,
      longitude: json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null,
      streetAddress: json['street_address'],
    );
  }
}

int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is String) {
    return int.tryParse(value);
  }
  return value is int ? value : null;
}
