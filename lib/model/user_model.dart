class UserModel {
  User? user;
  String? token;

  UserModel({this.user, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
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
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
