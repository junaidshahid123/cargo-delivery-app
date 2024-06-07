// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:cargo_delivery_app/main.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as apiClient;
import '../../api/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

import 'api_structure.dart';
import 'application_url.dart';
import 'auth_controller.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.sharedPreferences});

  String? getAuthToken() {
    try {
      UserModel? userInfo = getLoginUserData();
      return userInfo?.token;
    } catch (e) {
      throw Exception(e);
    }
  }

  void saveLoginUserData({required UserModel user}) {
    try {
      sharedPreferences.setString('Login', json.encode(user.toJson()));
    } catch (e) {
      throw Exception(e);
    }
  }

  void setSharedPreferenceFcmToken({required String fcmToken}) {
    try {
      sharedPreferences.setString('FcmToken', fcmToken);
    } catch (e) {
      throw Exception(e);
    }
  }

  String? getFcmToken() {
    try {
      return sharedPreferences.getString('FcmToken');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> updateFcmToken(
      {required String fcmToken}) async {
    try {
      APISTRUCTURE apiObject = APISTRUCTURE(
        apiUrl: 'updateFcmtokenurlhere',
        apiRequestMethod: APIREQUESTMETHOD.POST,
        isWantSuccessMessage: false,
        body: apiClient.FormData.fromMap({
          "fcm_token": fcmToken,
        }),
      );
      return await apiObject.requestAPI(
          isShowLoading: false, isCheckAuthorization: true);
    } catch (e) {
      throw Exception(e);
    }
  }

  UserModel? getLoginUserData() {
    try {
      String? userData = sharedPreferences.getString(
        'Login',
      );
      return userData != null
          ? UserModel.fromJson(json.decode(userData))
          : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String password,
    required String mobileNumber,
    String? userType,
    String? fcmToken
  }) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.LOGIN_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: apiClient.FormData.fromMap({
        "password": password,
        "mobile": mobileNumber,
        "user_type": userType,
        "device_id": 'this is device id',
        "device_token": fcmToken,
      }),
    );


    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: false);
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.DELETEUSER_URL,
      apiRequestMethod: APIREQUESTMETHOD.GET,
      isWantSuccessMessage: true,
    );

    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: false);
  }

// Register
  Future<Map<String, dynamic>> registerUser(
      {required String fullName,
      required String email,
      required String mobileNumber,
      required String password,
      required String confirmPass}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.REGISTER_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: apiClient.FormData.fromMap({
        "name": fullName,
        "email": email,
        'password': password,
        "password_confirmation": confirmPass,
        "mobile": mobileNumber,
        "user_type": '1',
        "image": '',
        "name_ar": '',
        "address": ''
      }),
    );

    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: false);
  }

// OTP Generating Api
  Future<Map<String, dynamic>> genearateOtp(
      {String? smsText, String? cnic, int? islogin}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GENERATEOTP_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {},
    );

    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: false);
  }

  //Verify Otp
  Future<Map<String, dynamic>> verifyOTP({String? code, int? islogin}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
        apiUrl: ApplicationUrl.VERIFYOTP_URL,
        apiRequestMethod: APIREQUESTMETHOD.POST,
        isWantSuccessMessage: true,
        body: {});

    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> logout() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.LOGOUT_URL,
      apiRequestMethod: APIREQUESTMETHOD.GET,
      isWantSuccessMessage: true,
    );
    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: false);
  }

// Reset Password
  Future<Map<String, dynamic>> resetPassword(
      {required String password, required String confirmPassword}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.RESETPASS_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: apiClient.FormData.fromMap({
        "mobile": Get.find<AuthController>()
            .authRepo
            .getLoginUserData()
            ?.user
            ?.mobile,
        "password": password,
        "password_confirmation": confirmPassword,
      }),
    );
    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: false);
  }

  //Uppdate Info
  Future<Map<String, dynamic>> updateUserInfo({
    required String name,
    required String email,
    String? userName,
    String? registerationNo,
    String? signature,
  }) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: '',
      apiRequestMethod: APIREQUESTMETHOD.PUT,
      isWantSuccessMessage: true,
      body: {
        "name": name,
        "email": email,
        "username": userName,
        "signature": signature,
        "registration_no": registerationNo,
      },
    );
    return await apiObject.requestAPI(
        isShowLoading: true, isCheckAuthorization: true);
  }

  bool isLoggedIn() {
    return getLoginUserData() != null;
  }

  bool clearSharedData() {
    sharedPreferences.remove('Login');
    sharedPreferences.clear();
    return true;
  }

  Future<void> saveUserNumberAndPassword(
      String number, String password, String countryCode) async {
    try {
      await sharedPreferences.setString('AppConstants.USER_PASSWORD', password);
    } catch (e) {
      rethrow;
    }
  }

  String getUserPassword() {
    return sharedPreferences.getString('AppConstants.USER_PASSWORD') ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool('AppConstants.NOTIFICATION') ?? true;
  }

  // void setNotificationActive(bool isActive) {
  //   // if(isActive) {
  //   //   updateToken();
  //   // }else {
  //     if(!GetPlatform.isWeb) {
  //       FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
  //       if(isLoggedIn()) {
  //         FirebaseMessaging.instance.unsubscribeFromTopic('zone_${Get.find<LocationController>().getUserAddress().zoneId}_customer');
  //       }
  //     }
  //   }
  //   sharedPreferences.setBool(AppConstants.NOTIFICATION, isActive);
}
