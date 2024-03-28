// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as apiClient;
import '../../api/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/login/user_model.dart';
import 'api_structure.dart';
import 'application_url.dart';
import 'auth_controller.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.sharedPreferences});

  String? getAuthToken() {
    try {
      UserModel? userInfo = getLoginUserData();
      return userInfo?.data?.accessToken;
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

  Future<Map<String, dynamic>> updateFcmToken({required String fcmToken}) async {
    try {
      APISTRUCTURE apiObject = APISTRUCTURE(
        apiUrl: 'updateFcmtokenurlhere',
        apiRequestMethod: APIREQUESTMETHOD.POST,
        isWantSuccessMessage: false,
        body: apiClient.FormData.fromMap({
          "fcm_token": fcmToken,
        }),
      );
      return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
    } catch (e) {
      throw Exception(e);
    }
  }

  UserModel? getLoginUserData() {
    try {
      String? userData = sharedPreferences.getString(
        'Login',
      );
      return userData != null ? UserModel.fromJson(json.decode(userData)) : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String cnic,
    required String mobileNumber,
    String? fcmToken,
    String? metaData,
  }) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.LOGIN_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {
        "CnicNumber": cnic,
        "MobileNum": mobileNumber,
        "meta_data": metaData ?? 'Android__14__Google sdk_gphone64_x86_64__9a0112a0ad6ea61d__fcmToken__2.0.0',
        "fcmToken": getFcmToken()
      },
    );

    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: false);
  }

// Register
  Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String cnic,
    required String mobileNumber,
    String? fcmToken,
  }) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.REGISTER_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: apiClient.FormData.fromMap({
        "fullName": fullName,
        "cnicNumber": cnic,
        "mobileNumber": mobileNumber,
        // 'fcm_token': getFcmToken(),
      }),
    );

    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: false);
  }

// OTP Generating Api
  Future<Map<String, dynamic>> genearateOtp({String? smsText, String? cnic, int? islogin}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GENERATEOTP_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {
        "sms_text":
            "Your authentication code for M-TAG One Network app is VERIFICATION_CODE_HERE. Never share it with anyone, ever.",
        "CnicNumber": cnic,
        "is_login": islogin
      },
    );

    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: false);
  }

  //Verify Otp
  Future<Map<String, dynamic>> verifyOTP({String? code, int? islogin}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
        apiUrl: ApplicationUrl.VERIFYOTP_URL,
        apiRequestMethod: APIREQUESTMETHOD.POST,
        isWantSuccessMessage: true,
        body: {"Code": code, "is_login": islogin, "meta_data": "", "fcmToken": getAuthToken()});

    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> logout() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.LOGOUT_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: apiClient.FormData.fromMap({
        "token_value": Get.find<AuthController>().authRepo.getAuthToken(),
      }),
    );
    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: false);
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
    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: true);
  }

  bool isLoggedIn() {
    return getLoginUserData() != null;
  }

  bool clearSharedData() {
    sharedPreferences.remove('Login');
    sharedPreferences.clear();
    return true;
  }

  Future<void> saveUserNumberAndPassword(String number, String password, String countryCode) async {
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
