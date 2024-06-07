import 'dart:io';
import 'package:dio/dio.dart' as dio;
import '../../api/application_url.dart';
import 'api_constants.dart';
import 'api_structure.dart';

//testing comment
class UserRepo {
  UserRepo();

  Future<Map<String, dynamic>> registerUser({
    required String cnic,
    required String fullName,
    required String mobileNumber,
    String? fcmToken,
  }) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: '',
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {
        "name": fullName,
        "PhoneNumber": mobileNumber,
        "CnicNumber": cnic,
        "fcm_token": fcmToken,
      },
    );

    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: true);
  }

//Confirm Locatiom
  Future<Map<String, dynamic>> confirmLocation({
    required String userId,
    required String address,
    required String lat,
    required String lang,
    required String city,
  }) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.CONFIRMLOCATION_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {
        "user_id": userId,
        "street_address": address,
        "latitude": lat,
        "longitude": lang,
        "city": city,
      },
    );
    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: true);
  }

// DashBoard Data
  Future<Map<String, dynamic>> getCategories(
      {String? appVersion, deviceID}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETALLCATEGORIES_URL,
      apiRequestMethod: APIREQUESTMETHOD.GET,
      isWantSuccessMessage: true,
    );

    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: true);
  }

// Get Banners
  Future<Map<String, dynamic>> getBanners(
      {String? appVersion, deviceID}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETBANNERS_URL,
      apiRequestMethod: APIREQUESTMETHOD.GET,
      isWantSuccessMessage: true,
    );

    return await apiObject.requestAPI(
        isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getOffersList() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.RIDEREQUESTS_URL,
      apiRequestMethod: APIREQUESTMETHOD.GET,
      isWantSuccessMessage: true,
    );

    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> acceptDriverRequest({
    required String requestId,
    required String offerId,
    required String amount,
    required String card,
    String? description,
  }) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.ACEPTRIDEREQUESTS_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      body: dio.FormData.fromMap({
        "request_id": requestId,
        "offer_id": offerId,
        "amount": amount,
        "card": 4111111111111111,
        "description": "From makkah to madinah",
        "payment_method": 2,
      }),
      isWantSuccessMessage: true,
    );

    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> addFeedBack({
    String? email,
    String? fullName,
    String? cnic,
    String? mobileNumber,
    String? remarks,
    String? itokenNo,
    String? vehicleCategory,
    String? complaintCategory,
    String? vehicleNumber,
    String? dataofIssue,
  }) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: '',
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: dio.FormData.fromMap({
        "cnic": cnic ?? '',
        "fullName": fullName ?? '',
        "mobileNumber": mobileNumber,
        'itokenNo': '',
        'vehicleCategory': '',
        'complaintCategory': '',
        'vehicleNumber': '',
        'remarks': remarks,
      }),
    );
    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> createRideRequest({
    required List<File> image,
    required String? category_id,
    required String? parcel_city,
    required String? parcelLat,
    required String? parcelLong,
    required String? parcellAddress,
    required String? receiveLat,
    required String? receiverLong,
    required String? receiverAddress,
    required String? receiverMob,
    required String? delivery_date,
  }) async {
    List<dio.MultipartFile> imageFiles = [];

    for (File file in image) {
      String fileName = file.path.split('/').last;
      imageFiles
          .add(await dio.MultipartFile.fromFile(file.path, filename: fileName));
    }

    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.CREATERIDEREQUEST_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: dio.FormData.fromMap({
        "parcel_lat": parcelLat,
        "parcel_long": parcelLong,
        "parcel_address": parcellAddress,
        "receiver_lat": receiveLat,
        "receiver_long": receiverLong,
        "receiver_address": receiverAddress,
        "receiver_mobile": receiverMob,
        "category_id": category_id,
        "delivery_date": delivery_date,
        "parcel_city": parcel_city,
        "images[]": imageFiles,
      }),
    );

    print(
        'Images in createRideRequest: ${imageFiles.map((e) => e.filename).toList()}');

    return await apiObject.requestAPI(
      isShowLoading: true,
      isCheckAuthorization: true,
    );
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GENERATEOTP_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
    );
    return await apiObject.requestAPI(
        isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getRideRequests() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GENERATEOTP_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
    );
    return await apiObject.requestAPI(
        isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getAllUsersTrips() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETALLUSERTRIPS_URL,
      apiRequestMethod: APIREQUESTMETHOD.GET,
      isWantSuccessMessage: true,
    );
    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: true);
  }
}
