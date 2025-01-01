class MDAllOffers {
  int? id;
  String? from;
  String? to;
  String? date;
  String? time;
  String? userId;
  String? price;
  Null? description;
  String? createdAt;
  String? updatedAt;

  MDAllOffers(
      {this.id,
        this.from,
        this.to,
        this.date,
        this.time,
        this.userId,
        this.price,
        this.description,
        this.createdAt,
        this.updatedAt});

  MDAllOffers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    date = json['date'];
    time = json['time'];
    userId = json['user_id'];
    price = json['price'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['date'] = this.date;
    data['time'] = this.time;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}