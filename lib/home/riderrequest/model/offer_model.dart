class OffersModel {
  List<Offers>? offers;

  OffersModel({this.offers});

  OffersModel.fromJson(Map<String, dynamic> json) {
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  int? id;
  String? requestId;
  String? amount;
  String? userId;
  String? isAccept;
  String? createdAt;
  String? updatedAt;
  Request? request;
  User? user;

  Offers(
      {this.id,
      this.requestId,
      this.amount,
      this.userId,
      this.isAccept,
      this.createdAt,
      this.updatedAt,
      this.request,
      this.user});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    amount = json['amount'];
    userId = json['user_id'];
    isAccept = json['is_accept'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    request =
        json['request'] != null ? Request.fromJson(json['request']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['request_id'] = requestId;
    data['amount'] = amount;
    data['user_id'] = userId;
    data['is_accept'] = isAccept;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (request != null) {
      data['request'] = request!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Request {
  int? id;
  String? userId;
  String? parcelLat;
  String? parcelLong;
  String? parcelAddress;

  Request(
      {this.id,
      this.userId,
      this.parcelLat,
      this.parcelLong,
      this.parcelAddress});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    parcelLat = json['parcel_lat'];
    parcelLong = json['parcel_long'];
    parcelAddress = json['parcel_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['parcel_lat'] = parcelLat;
    data['parcel_long'] = parcelLong;
    data['parcel_address'] = parcelAddress;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? latitude;
  String? longitude;
  String? streetAddress;

  User(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.latitude,
      this.longitude,
      this.streetAddress});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    streetAddress = json['street_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['street_address'] = streetAddress;
    return data;
  }
}
