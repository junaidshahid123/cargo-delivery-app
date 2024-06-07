class BannersModel {
  int? status;
  List<Banners>? banners;

  BannersModel({this.status, this.banners});

  BannersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int? id;
  String? image;
  String? status;
  String? slug;

  String? imageBaseUrl;

  Banners({this.id, this.image, this.status, this.slug, this.imageBaseUrl});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    slug = json['slug'];

    imageBaseUrl = json['image_base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['status'] = status;
    data['slug'] = slug;
    data['image_base_url'] = imageBaseUrl;
    return data;
  }
}
