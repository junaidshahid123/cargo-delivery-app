class MDGetVehicleCategories {
  String? status;
  List<Categories>? categories;
  String? imageBaseUrl;

  MDGetVehicleCategories({this.status, this.categories, this.imageBaseUrl});

  MDGetVehicleCategories.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    imageBaseUrl = json['image_base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['image_base_url'] = this.imageBaseUrl;
    return data;
  }
}

class Categories {
  String? id;
  String? name;
  Null? nameAr;
  String? image;
  String? status;
  String? description;
  String? createdBy;
  String? adminChoice;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
        this.name,
        this.nameAr,
        this.image,
        this.status,
        this.description,
        this.createdBy,
        this.adminChoice,
        this.createdAt,
        this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    image = json['image'];
    status = json['status'];
    description = json['description'];
    createdBy = json['created_by'];
    adminChoice = json['admin_choice'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['status'] = this.status;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['admin_choice'] = this.adminChoice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}