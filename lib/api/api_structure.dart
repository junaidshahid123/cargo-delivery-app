// ignore_for_file: library_prefixes

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as apiClient;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../api/api_constants.dart';
import 'api_loader.dart';
import 'auth_controller.dart';

class APISTRUCTURE {
  final String apiUrl;
  dynamic body;
  final bool isWantSuccessMessage;
  final String apiRequestMethod;
  String? contentType;

  APISTRUCTURE({
    this.body,
    required this.apiUrl,
    required this.apiRequestMethod,
    this.isWantSuccessMessage = false,
    this.contentType,
  });
  Future<Map<String, dynamic>> requestAPI({bool isShowLoading = false, bool isCheckAuthorization = true}) async {
    String api = "";
    if (isShowLoading) {
      ApiLoader.show();
    }
    try {
      api = BASE_URL + apiUrl;
      Map<String, String> header = {};
      if (contentType != null) {
        header.addAll({"Content-Type": contentType!});
      }
      log('${Get.find<AuthController>().authRepo.getAuthToken()}');
      header.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}"
      });
      apiClient.Dio dio = apiClient.Dio();
      apiClient.Options options = apiClient.Options(
          followRedirects: false,
          headers: header,

          /// Enable for testing complete status
          validateStatus: (int? status) {
            return (status ?? 500) < 600;
          });
      apiClient.Response<dynamic> response = apiRequestMethod == APIREQUESTMETHOD.GET
          ? await dio.get(api, options: options)
          : apiRequestMethod == APIREQUESTMETHOD.POST
              ? await dio.post(api, data: body, options: options)

              /// Else for Delete Method
              : apiRequestMethod == APIREQUESTMETHOD.DELETE
                  ? await dio.delete(api, options: options)
                  : await dio.put(api, data: body, options: options);
      log('$api response:[${response.statusCode}]----> $response');

      if (isShowLoading) {
        ApiLoader.hide();
      }
      if (response.statusCode == 200) {
        return {APIRESPONSE.SUCCESS: response.data};
      }

      Map<String, dynamic> responseResult = {};
      if (response.statusCode != null) {
        responseResult = response.data;
      } else {
        responseResult = {APIRESPONSE.ERROR: "Something went wrong"};
      }
      return responseResult;
    } on SocketException {
      if (isShowLoading) {
        ApiLoader.hide();
      }
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Ok'),
            )
          ],
          content: const Text('Internet Connection Error'),
        ),
      );

      return {APIRESPONSE.EXCEPTION: APIEXCEPTION.SOCKET};
    } on HttpException {
      if (isShowLoading) {
        ApiLoader.hide();
      }
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Ok'),
            )
          ],
          content: const Text('Internet Connection Error'),
        ),
      );
      return {APIRESPONSE.EXCEPTION: APIEXCEPTION.HTTP};
    } on FormatException {
      if (isShowLoading) {
        ApiLoader.hide();
      }
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Ok'),
            )
          ],
          content: const Text('Server Bad response'),
        ),
      );

      return {APIRESPONSE.EXCEPTION: APIEXCEPTION.FORMAT};
    } on apiClient.DioException catch (e) {
      Map<String, dynamic> exception = {};
      if (isShowLoading) {
        ApiLoader.hide();
      }
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Ok'),
            )
          ],
          content: Text(e.message ?? ''),
        ),
      );
      switch (e.type) {
        case apiClient.DioExceptionType.connectionTimeout:
          exception = {APIRESPONSE.EXCEPTION: "Connection timeout"};
          break;
        case apiClient.DioExceptionType.sendTimeout:
          exception = {APIRESPONSE.EXCEPTION: "Sent timeout"};
          break;
        case apiClient.DioExceptionType.receiveTimeout:
          exception = {APIRESPONSE.EXCEPTION: "Receive timeout"};
          break;
        case apiClient.DioExceptionType.connectionError:
          exception = {APIRESPONSE.EXCEPTION: "Server error"};
          break;
        case apiClient.DioExceptionType.badCertificate:
          exception = {APIRESPONSE.EXCEPTION: "Server Certificate Error"};

          break;
        case apiClient.DioExceptionType.badResponse:
          exception = {APIRESPONSE.EXCEPTION: "Bad Request"};
          break;
        case apiClient.DioExceptionType.unknown:
          exception = {APIRESPONSE.EXCEPTION: "Server Unknown Error"};

          break;
        case apiClient.DioExceptionType.cancel:
          showCupertinoModalPopup(
            context: Get.context!,
            builder: (context) => CupertinoAlertDialog(
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Get.back(),
                  child: const Text('Ok'),
                )
              ],
              content: const Text('Request cancelled'),
            ),
          );
          exception = {APIRESPONSE.EXCEPTION: "Cancel"};
          break;
      }
      return exception;
    } catch (error) {
      if (isShowLoading) {
        ApiLoader.hide();
      }
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Ok'),
            )
          ],
          content: Text(error.toString().contains("SocketException") ? "Internet Connection Error" : error.toString()),
        ),
      );

      return error.toString().contains("SocketException")
          ? {APIRESPONSE.EXCEPTION: "Internet Connection Error"}
          : {APIRESPONSE.EXCEPTION: APIEXCEPTION.UNKNOWN};
    }
  }
}
