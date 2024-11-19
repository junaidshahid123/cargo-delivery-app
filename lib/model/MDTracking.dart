class MDTracking {
  Data? data;

  MDTracking({this.data});

  MDTracking.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  Null? channelName;
  String? categoryId;
  String? code;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;
  DriverCurrentRecord? driverCurrentRecord;

  Data(
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
        this.driverCurrentRecord});

  Data.fromJson(Map<String, dynamic> json) {
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
    driverCurrentRecord = json['driver_current_record'] != null
        ? new DriverCurrentRecord.fromJson(json['driver_current_record'])
        : null;
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
    if (this.driverCurrentRecord != null) {
      data['driver_current_record'] = this.driverCurrentRecord!.toJson();
    }
    return data;
  }
}

class DriverCurrentRecord {
  int? id;
  String? requestId;
  String? userId;
  String? lat;
  String? long;
  String? address;
  String? isStart;
  String? isEnd;
  String? isRead;
  String? createdAt;
  String? updatedAt;

  DriverCurrentRecord(
      {this.id,
        this.requestId,
        this.userId,
        this.lat,
        this.long,
        this.address,
        this.isStart,
        this.isEnd,
        this.isRead,
        this.createdAt,
        this.updatedAt});

  DriverCurrentRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    userId = json['user_id'];
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
    isStart = json['is_start'];
    isEnd = json['is_end'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_id'] = this.requestId;
    data['user_id'] = this.userId;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['address'] = this.address;
    data['is_start'] = this.isStart;
    data['is_end'] = this.isEnd;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}