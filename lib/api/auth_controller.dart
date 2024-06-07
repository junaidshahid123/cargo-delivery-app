import 'dart:async';
import 'dart:developer';
import 'package:cargo_delivery_app/auth_screen/login_screen.dart';
import 'package:cargo_delivery_app/home/confirm_location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api/api_constants.dart';

import '../model/user_model.dart';
import './auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  int? forgotUserId;
  String? forgotUserPhoneNo;
  final bool _notification = true;
  final bool _acceptTerms = true;
  bool get notification => _notification;
  bool get acceptTerms => _acceptTerms;
  String? _userPhoneNo;
  String? _userCountryCode;
  String? get userPhoneNo => _userPhoneNo;
  String? get userCountryCode => _userCountryCode;

  UserModel? getLoginUserData() {
    return authRepo.getLoginUserData();
  }

  String? getFcmToken() {
    return authRepo.getFcmToken();
  }

  void updateLoginUserData({required UserModel user}) {
    authRepo.saveLoginUserData(user: user);
  }

  bool isLoginUser({required int userId}) {
    return true;
  }

  bool clearSharedData() {
    authRepo.clearSharedData();
    return true;
  }
  //Login Api

  Future<Map<String, dynamic>> login({
    required String password,
    required String mobileNumber,
    String? userType,
    required String fcmToken
  }) async {
    Map<String, dynamic> response = await authRepo.login(
      password: password,
      mobileNumber: mobileNumber,
      userType: userType, fcmToken:fcmToken
    );
    log(response.toString());
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      Map<String, dynamic> result = response[APIRESPONSE.SUCCESS];
      authRepo.saveLoginUserData(user: UserModel.fromJson(result));
      Get.offAll(() => const LocationPage());
    } else {
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: Text('${response['message']}'),
          actions: [
            CupertinoDialogAction(
              onPressed: Get.back,
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }
    return response;
  }

  //Sign Up Api
  Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String mobileNumber,
    required String email,
    required String password,
    String? confirmPass,
  }) async {
    Map<String, dynamic> response = await authRepo.registerUser(
        fullName: fullName,
        email: email,
        mobileNumber: mobileNumber,
        password: password,
        confirmPass: confirmPass ?? '');

    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: const Text('registered successfully'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.to(() => LoginScreen()),
              child: const Text('Ok'),
            )
          ],
        ),
      );
    } else {
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: Text('${response['message']}'),
          actions: [
            CupertinoDialogAction(
              onPressed: Get.back,
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }

    return response;
  }

  Future<Map<String, dynamic>> updateFcmToken(
      {required String fcmToken}) async {
    debugPrint("updateFcmToken:->$fcmToken");
    Map<String, dynamic> response =
        await authRepo.updateFcmToken(fcmToken: fcmToken);
    authRepo.setSharedPreferenceFcmToken(fcmToken: fcmToken);
    return response;
  }

//
  bool isLogedIn() {
    return authRepo.isLoggedIn();
  }

//Logout
  Future<Map<String, dynamic>> logout() async {
    Map<String, dynamic> response = await authRepo.logout();
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      authRepo.clearSharedData();
      Get.offAll(() => LoginScreen());
    }
    return response;
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    Map<String, dynamic> response = await authRepo.deleteAccount();
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      authRepo.clearSharedData();
      Get.offAll(() => LoginScreen());
    }
    return response;
  }

  //Generate OTP
  Future<Map<String, dynamic>> generateOTP({
    String? smsText,
    String? cnic,
    int? islogin,
  }) async {
    Map<String, dynamic> response =
        await authRepo.genearateOtp(cnic: cnic, islogin: islogin);

    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      authRepo.saveLoginUserData(user: UserModel());
      Get.offAllNamed('/otp',
          arguments: {'mobileNum': '', 'loginKey': 0, 'cnic': cnic});
    } else {
      showCupertinoModalPopup(
          context: Get.context!,
          builder: (context) => CupertinoAlertDialog(
                actions: [
                  CupertinoDialogAction(
                    onPressed: Get.back,
                    child: const Text('Ok'),
                  )
                ],
                content: Text('${response['Message']}'),
              ));
    }

    return response;
  }

  //resend
  Future<Map<String, dynamic>> resendOTP({
    String? smsText,
    String? cnic,
    int? islogin,
  }) async {
    Map<String, dynamic> response =
        await authRepo.genearateOtp(cnic: cnic, islogin: islogin);

    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      authRepo.saveLoginUserData(user: UserModel());
    } else {
      showCupertinoModalPopup(
          context: Get.context!,
          builder: (context) => CupertinoAlertDialog(
                actions: [
                  CupertinoDialogAction(
                    onPressed: Get.back,
                    child: const Text('Ok'),
                  )
                ],
                content: Text('${response['Message']}'),
              ));
    }

    return response;
  }

  //
  Future<Map<String, dynamic>> resetPassword({
    String? password,
    String? conformPassword,
  }) async {
    Map<String, dynamic> response = await authRepo.resetPassword(
        password: password ?? '', confirmPassword: conformPassword ?? '');

    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      showCupertinoModalPopup(
          context: Get.context!,
          builder: (context) => CupertinoAlertDialog(
                actions: [
                  CupertinoDialogAction(
                    onPressed: Get.back,
                    child: const Text('Ok'),
                  )
                ],
                content: Text('$response'),
              ));
    } else {
      showCupertinoModalPopup(
          context: Get.context!,
          builder: (context) => CupertinoAlertDialog(
                actions: [
                  CupertinoDialogAction(
                    onPressed: Get.back,
                    child: const Text('Ok'),
                  )
                ],
                content: Text('${response['Message']}'),
              ));
    }

    return response;
  }

  //Verify OTP
  Future<Map<String, dynamic>> verifyOTP(
    String? code,
    int? islogin,
  ) async {
    Map<String, dynamic> response =
        await authRepo.verifyOTP(code: code, islogin: islogin);
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      authRepo.saveLoginUserData(user: UserModel());
      Future.delayed(const Duration(seconds: 1), () async {
        await Get.to(() => const LocationPage());
      });
    } else {
      showCupertinoModalPopup(
          context: Get.context!,
          builder: (context) => CupertinoAlertDialog(
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Ok'),
                  )
                ],
                content: Text('${response['Message']}'),
              ));
    }

    return response;
  }
}
