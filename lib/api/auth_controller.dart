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
    int? userType,
    required String fcmToken,
  }) async {
    // Debug: Print input parameters
    print('Password: $password');
    print('Mobile Number: $mobileNumber');
    print('User Type: $userType');
    print('FCM Token: $fcmToken');

    // Call the login API
    Map<String, dynamic> response = await authRepo.login(
      password: password,
      mobileNumber: mobileNumber,
      userType: userType,
      fcmToken: fcmToken,
    );

    // Debug: Log the entire response
    log('API Response: $response');

    // Check for a valid SUCCESS response
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      Map<String, dynamic> result = response[APIRESPONSE.SUCCESS];

      // Debug: Log the result payload
      print('Result Payload: $result');

      if (result.containsKey('message') &&
          result['message'] == 'User not found') {
        print('Condition matched: User not found');
        String message = 'User not found'.tr;

        showCupertinoModalPopup(
          context: Get.context!,
          builder: (_) => CupertinoAlertDialog(
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                onPressed: Get.back,
                child: Text('Ok'.tr),
              ),
            ],
          ),
        );
      } else if (result.containsKey('message') &&
          result['message'] == 'user_type does not matched') {
        print('Condition matched: user_type does not matched');
        String message = 'User Type does not matched, Try another number'.tr;

        showCupertinoModalPopup(
          context: Get.context!,
          builder: (_) => CupertinoAlertDialog(
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                onPressed: Get.back,
                child: Text('Ok'.tr),
              ),
            ],
          ),
        );
      } else {
        print('Login successful, proceeding to save user data.');
        authRepo.saveLoginUserData(user: UserModel.fromJson(result));
        Get.offAll(() => LocationPage());
      }
    }
    // Handle error responses (e.g., 403 status code)
    else if (response.containsKey('message') &&
        response['message'] == 'User not found') {
      print('Condition matched: User not found in error response');
      String message = 'User not found'.tr;

      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: Get.back,
              child: Text('Ok'.tr),
            ),
          ],
        ),
      );
    } else {
      // Handle other error responses
      print('Error Response: ${response['message']}');
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: Text('${response['message']}'),
          actions: [
            CupertinoDialogAction(
              onPressed: Get.back,
              child: Text('Ok'.tr),
            ),
          ],
        ),
      );
    }
    return response;
  }

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
      // Successful Registration
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: Text('registered successfully'.tr),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.to(() => LoginScreen()),
              child: Text('Ok'.tr),
            )
          ],
        ),
      );
    } else {
      // Handle Validation Errors
      String errorMessage = _formatValidationErrors(response['errors']);
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: Text(errorMessage),
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

// Function to Format Validation Errors Based on Locale
  String _formatValidationErrors(Map<String, dynamic>? errors) {
    if (errors == null || errors.isEmpty)
      return 'An unexpected error occurred.'.tr;

    // Determine Current Locale
    Locale currentLocale = Get.locale ?? const Locale('en');
    bool isArabic = currentLocale.languageCode == 'ar';

    // Error Translations
    Map<String, Map<String, String>> translations = {
      'email': {
        'validation.unique': isArabic
            ? 'هذا البريد الإلكتروني مسجل بالفعل.'
            : 'This email is already registered.',
      },
      'mobile': {
        'validation.unique': isArabic
            ? 'هذا الرقم مسجل بالفعل.'
            : 'This mobile number is already registered.',
      },
    };

    List<String> formattedErrors = [];
    errors.forEach((field, messages) {
      for (var messageKey in messages) {
        String translatedMessage =
            translations[field]?[messageKey] ?? '$field: $messageKey';
        formattedErrors.add(translatedMessage);
      }
    });

    return formattedErrors.join('\n');
  }

  //UpdateUser
  Future<Map<String, dynamic>> updateUser({
    required String fullName,
    required String mobileNumber,
    required String email,
    required String street,
  }) async {
    Map<String, dynamic> response = await authRepo.updateUserInfo(
      name: fullName,
      email: email,
      mobile: mobileNumber,
      street: street,
    );

    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      print("THis is update user success");
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: const Text('User Updated Successfully'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.offAll(() => LoginScreen()),
              child: const Text('Ok'),
            )
          ],
        ),
      );
    } else {
      print("THis is update user failed");
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
        await Get.to(() => LocationPage());
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
