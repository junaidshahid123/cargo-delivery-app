class MDCities {
  String? sno;
  String? countrySno;
  String? cityNameAr;
  String? cityName;
  String? cityStatus;
  String? status;

  MDCities(
      {this.sno,
        this.countrySno,
        this.cityNameAr,
        this.cityName,
        this.cityStatus,
        this.status});

  MDCities.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    countrySno = json['country_sno'];
    cityNameAr = json['city_name_ar'];
    cityName = json['city_name'];
    cityStatus = json['city_status'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['country_sno'] = this.countrySno;
    data['city_name_ar'] = this.cityNameAr;
    data['city_name'] = this.cityName;
    data['city_status'] = this.cityStatus;
    data['status'] = this.status;
    return data;
  }
}