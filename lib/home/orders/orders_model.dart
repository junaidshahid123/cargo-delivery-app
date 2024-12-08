
class MDAllRides {
  int? status;
  List<AllRides>? allRides;

  MDAllRides({this.status, this.allRides});

  MDAllRides.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['allRides'] != null) {
      allRides = <AllRides>[];
      json['allRides'].forEach((v) {
        allRides!.add(new AllRides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.allRides != null) {
      data['allRides'] = this.allRides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllRides {
  int? id;
  String? userId;
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
  String? status;
  String? paymentStatus;
  String? amount;
  Null? invoiceId;
  String? offerId;
  Null? channelName;
  String? categoryId;
  String? code;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;
  Offer? offer;
  User? user;

  AllRides(
      {this.id,
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
        this.offer,
        this.user});

  AllRides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    images = json['images'];
    parcelLat = json['parcel_lat'];
    parcelLong = json['parcel_long'];
    parcelAddress = json['parcel_address'];
    receiverLat = json['receiver_lat'];
    receiverLong = json['receiver_long'];
    receiverAddress = json['receiver_address'];
    receiverMobile = json['receiver_mobile'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    amount = json['amount'];
    invoiceId = json['invoice_id'];
    offerId = json['offer_id'];
    channelName = json['channel_name'];
    categoryId = json['category_id'];
    code = json['code'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    offer = json['offer'] != null ? new Offer.fromJson(json['offer']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['amount'] = this.amount;
    data['invoice_id'] = this.invoiceId;
    data['offer_id'] = this.offerId;
    data['channel_name'] = this.channelName;
    data['category_id'] = this.categoryId;
    data['code'] = this.code;
    data['payment_method'] = this.paymentMethod;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.offer != null) {
      data['offer'] = this.offer!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Offer {
  int? id;
  String? requestId;
  String? amount;
  String? userId;
  String? isAccept;
  String? isReject;
  String? createdAt;
  String? updatedAt;

  Offer(
      {this.id,
        this.requestId,
        this.amount,
        this.userId,
        this.isAccept,
        this.isReject,
        this.createdAt,
        this.updatedAt});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    amount = json['amount'];
    userId = json['user_id'];
    isAccept = json['is_accept'];
    isReject = json['is_reject'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_id'] = this.requestId;
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['is_accept'] = this.isAccept;
    data['is_reject'] = this.isReject;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  Null? nameAr;
  String? email;
  String? image;
  Null? emailVerifiedAt;
  String? mobile;
  String? otp;
  String? status;
  String? userType;
  String? streetAddress;
  String? city;
  Null? state;
  Null? postalCode;
  Null? country;
  String? latitude;
  String? longitude;
  Null? twitter;
  Null? facebook;
  Null? instagram;
  Null? linkedin;
  String? categoryId;
  Null? drivingLicense;
  Null? numberPlate;
  String? bankId;
  Null? bankAccount;
  String? deviceToken;
  String? isAvailable;
  String? isRead;
  String? createdAt;
  String? updatedAt;

  User(
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
        this.deviceToken,
        this.isAvailable,
        this.isRead,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    email = json['email'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    otp = json['otp'];
    status = json['status'];
    userType = json['user_type'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
    categoryId = json['category_id'];
    drivingLicense = json['driving_license'];
    numberPlate = json['number_plate'];
    bankId = json['bank_id'];
    bankAccount = json['bank_account'];
    deviceToken = json['device_token'];
    isAvailable = json['is_available'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['device_token'] = this.deviceToken;
    data['is_available'] = this.isAvailable;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}