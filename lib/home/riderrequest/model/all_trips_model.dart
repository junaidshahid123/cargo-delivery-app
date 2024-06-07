class AlltripsModel {
  Data? data;

  AlltripsModel({this.data});

  AlltripsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class TripData {
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
  String? invoiceId;
  String? offerId;
  String? channelName;
  String? createdAt;
  String? updatedAt;
  UserData? user;

  TripData(
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
      this.createdAt,
      this.updatedAt,
      this.user});

  TripData.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['images'] = images;
    data['parcel_lat'] = parcelLat;
    data['parcel_long'] = parcelLong;
    data['parcel_address'] = parcelAddress;
    data['receiver_lat'] = receiverLat;
    data['receiver_long'] = receiverLong;
    data['receiver_address'] = receiverAddress;
    data['receiver_mobile'] = receiverMobile;
    data['status'] = status;
    data['payment_status'] = paymentStatus;
    data['amount'] = amount;
    data['invoice_id'] = invoiceId;
    data['offer_id'] = offerId;
    data['channel_name'] = channelName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserData {
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
  String? createdAt;
  String? updatedAt;

  UserData(
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
      this.createdAt,
      this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
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
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['email'] = email;
    data['image'] = image;
    data['email_verified_at'] = emailVerifiedAt;
    data['mobile'] = mobile;
    data['otp'] = otp;
    data['status'] = status;
    data['user_type'] = userType;
    data['street_address'] = streetAddress;
    data['city'] = city;
    data['state'] = state;
    data['postal_code'] = postalCode;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['twitter'] = twitter;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['linkedin'] = linkedin;
    data['category_id'] = categoryId;
    data['driving_license'] = drivingLicense;
    data['number_plate'] = numberPlate;
    data['bank_id'] = bankId;
    data['bank_account'] = bankAccount;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
