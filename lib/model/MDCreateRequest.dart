class MDCreateRequest {
  String? msg;
  Request? request;
  List<Drivers>? drivers;

  MDCreateRequest({this.msg, this.request, this.drivers});

  factory MDCreateRequest.fromJson(Map<String, dynamic> json) {
    var success = json['Success'];
    return MDCreateRequest(
      msg: success['msg'],
      request: success['request'] != null ? Request.fromJson(success['request']) : null,
      drivers: success['drivers'] != null
          ? List<Drivers>.from(success['drivers'].map((v) => Drivers.fromJson(v)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['msg'] = this.msg;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    if (this.drivers != null) {
      data['drivers'] = this.drivers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Request {
  int? userId;
  String? fromDate;
  String? toDate;
  String? images;
  String? parcelLat;
  String? parcelLong;
  String? parcelAddress;
  String? receiverLat;
  String? receiverLong;
  String? receiverAddress;
  String? receiverMobile;
  String? categoryId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Request(
      {this.userId,
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
        this.categoryId,
        this.updatedAt,
        this.createdAt,
        this.id});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      userId: json['user_id'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      images: json['images'],
      parcelLat: json['parcel_lat'],
      parcelLong: json['parcel_long'],
      parcelAddress: json['parcel_address'],
      receiverLat: json['receiver_lat'],
      receiverLong: json['receiver_long'],
      receiverAddress: json['receiver_address'],
      receiverMobile: json['receiver_mobile'],
      categoryId: json['category_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = this.userId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['images'] = this.images;
    data['parcel_lat'] = this.parcelLat;
    data['parcel_long'] = this.parcelLong;
    data['parcel_address'] = this.parcelAddress;
    data['receiver_lat'] = this.receiverLat;
    data['receiver_long'] = this.receiverLong;
    data['receiver_address'] = this.receiverAddress;
    data['receiver_mobile'] = this.receiverMobile;
    data['category_id'] = this.categoryId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Drivers {
  int? id;
  String? name;
  String? nameAr;
  String? email;
  String? image;
  String? emailVerifiedAt;
  String? mobile;
  String? otp;
  String? status;
  String? userType;
  String? streetAddress;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? latitude;
  String? longitude;
  String? twitter;
  String? facebook;
  String? instagram;
  String? linkedin;
  String? categoryId;
  String? drivingLicense;
  String? numberPlate;
  String? bankId;
  String? bankAccount;
  String? isRead;
  String? deviceToken;
  String? createdAt;
  String? updatedAt;

  Drivers(
      {this.id,
        this.name,
        this.nameAr,
        this.email,
        this.image,
        this.emailVerifiedAt,
        this.mobile,
        this.otp,
        this.status,
        this.userType,
        this.streetAddress,
        this.city,
        this.state,
        this.postalCode,
        this.country,
        this.latitude,
        this.longitude,
        this.twitter,
        this.facebook,
        this.instagram,
        this.linkedin,
        this.categoryId,
        this.drivingLicense,
        this.numberPlate,
        this.bankId,
        this.bankAccount,
        this.isRead,
        this.deviceToken,
        this.createdAt,
        this.updatedAt});

  factory Drivers.fromJson(Map<String, dynamic> json) {
    return Drivers(
      id: json['id'],
      name: json['name'],
      nameAr: json['name_ar'],
      email: json['email'],
      image: json['image'],
      emailVerifiedAt: json['email_verified_at'],
      mobile: json['mobile'],
      otp: json['otp'],
      status: json['status'],
      userType: json['user_type'],
      streetAddress: json['street_address'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      twitter: json['twitter'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      linkedin: json['linkedin'],
      categoryId: json['category_id'],
      drivingLicense: json['driving_license'],
      numberPlate: json['number_plate'],
      bankId: json['bank_id'],
      bankAccount: json['bank_account'],
      isRead: json['is_read'],
      deviceToken: json['device_token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['email'] = this.email;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['user_type'] = this.userType;
    data['street_address'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postal_code'] = this.postalCode;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['linkedin'] = this.linkedin;
    data['category_id'] = this.categoryId;
    data['driving_license'] = this.drivingLicense;
    data['number_plate'] = this.numberPlate;
    data['bank_id'] = this.bankId;
    data['bank_account'] = this.bankAccount;
    data['is_read'] = this.isRead;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
