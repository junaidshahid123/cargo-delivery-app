import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtag_flutterapp/constants/other_consts.dart';
import 'package:mtag_flutterapp/controller/home_controller.dart';
import '../../api/api_constants.dart';

import '../pages/login/user_model.dart';
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

  getLoginUserData() {
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
    required String cnic,
    required String mobileNumber,
    required String metaData,
  }) async {
    Map<String, dynamic> response = await authRepo.login(
      cnic: cnic,
      mobileNumber: mobileNumber,
      metaData: metaData,
    );

    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      Map<String, dynamic> result = response[APIRESPONSE.SUCCESS];

      authRepo.saveLoginUserData(
          user: UserModel(code: result['Code'], data: Data(accessToken: result['access_token'])));

      if (result["Code"] == '00') {
        await generateOTP(cnic: cnic, islogin: 1);

        if (result.isNotEmpty) {
          updateLoginUserData(user: UserModel(code: result['Code'], data: Data(accessToken: result['access_token'])));
        }

        Get.offAllNamed('/otp', arguments: {'mobileNum': mobileNumber, 'loginKey': 1, 'cnic': cnic});
      }
    } else {
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: Text('${response['Message']}'),
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
    required String cnic,
    required String fullName,
    required String mobileNumber,
    String? fcmToken,
  }) async {
    Map<String, dynamic> response =
        await authRepo.registerUser(cnic: cnic, fullName: fullName, mobileNumber: mobileNumber, fcmToken: fcmToken);

    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      Get.offAllNamed('/otp', arguments: {'mobileNum': mobileNumber, 'loginKey': 0, 'cnic': cnic});
    } else {
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: Text('${response['Message']}'),
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

  Future<Map<String, dynamic>> updateFcmToken({required String fcmToken}) async {
    debugPrint("updateFcmToken:->$fcmToken");
    Map<String, dynamic> response = await authRepo.updateFcmToken(fcmToken: fcmToken);
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
      Get.offAllNamed('/login');
    }
    return response;
  }

  //Generate OTP
  Future<Map<String, dynamic>> generateOTP({
    String? smsText,
    String? cnic,
    int? islogin,
  }) async {
    Map<String, dynamic> response = await authRepo.genearateOtp(cnic: cnic, islogin: islogin);

    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      authRepo.saveLoginUserData(user: UserModel(data: Data(accessToken: response[APIRESPONSE.SUCCESS]['Data'])));
      Get.offAllNamed('/otp', arguments: {'mobileNum': mobile.value, 'loginKey': 0, 'cnic': cnic});
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
    Map<String, dynamic> response = await authRepo.genearateOtp(cnic: cnic, islogin: islogin);

    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      authRepo.saveLoginUserData(user: UserModel(data: Data(accessToken: response[APIRESPONSE.SUCCESS]['Data'])));
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
    Map<String, dynamic> response = await authRepo.verifyOTP(code: code, islogin: islogin);
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      authRepo.saveLoginUserData(
          user: UserModel(
              code: response[APIRESPONSE.SUCCESS]['Code'],
              data: Data(accessToken: response[APIRESPONSE.SUCCESS]['Data'])));
      Future.delayed(const Duration(seconds: 1), () async {
        Get.find<HomeController>().initialized ? Get.find<HomeController>().refreshDashBoardData() : null;
        await Get.offAllNamed('/dashboard');
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
