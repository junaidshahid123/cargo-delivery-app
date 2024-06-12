class MDGetPaymentMethodList {
  String? status;
  List<PaymentMethod>? list;

  MDGetPaymentMethodList({this.status, this.list});

  MDGetPaymentMethodList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['list'] != null) {
      list = <PaymentMethod>[];
      json['list'].forEach((v) {
        list!.add(new PaymentMethod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethod {
  String? id;
  String? name;
  String? nameAr;
  String? publicKey;
  String? secretKey;
  String? status;
  String? slug;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  PaymentMethod(
      {this.id,
        this.name,
        this.nameAr,
        this.publicKey,
        this.secretKey,
        this.status,
        this.slug,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    publicKey = json['public_key'];
    secretKey = json['secret_key'];
    status = json['status'];
    slug = json['slug'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['public_key'] = this.publicKey;
    data['secret_key'] = this.secretKey;
    data['status'] = this.status;
    data['slug'] = this.slug;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
