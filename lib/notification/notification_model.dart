  class MDNotifications {
    List<Data>? data;

    MDNotifications({this.data});

    MDNotifications.fromJson(Map<String, dynamic> json) {
      if (json['data'] != null) {
        data = <Data>[];
        json['data'].forEach((v) {
          data!.add(new Data.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      if (this.data != null) {
        data['data'] = this.data!.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }

  class Data {
    int? id;
    String? userId;
    String? message;
    String? page;
    String? createdAt;
    String? updatedAt;

    Data(
        {this.id,
          this.userId,
          this.message,
          this.page,
          this.createdAt,
          this.updatedAt});

    Data.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      userId = json['user_id'];
      message = json['message'];
      page = json['page'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['user_id'] = this.userId;
      data['message'] = this.message;
      data['page'] = this.page;
      data['created_at'] = this.createdAt;
      data['updated_at'] = this.updatedAt;
      return data;
    }
  }