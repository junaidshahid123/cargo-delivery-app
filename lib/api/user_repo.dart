import 'package:dio/dio.dart' as dio;
import 'package:mtag_flutterapp/api/application_url.dart';

import '../constants/auth_utils.dart';
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

    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: true);
  }

// DashBoard Data
  Future<Map<String, dynamic>> getdashBoardData({String? appVersion, deviceID}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.DASHBOARD_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {"AppVer": "2.0.0", "deviceId": "0"},
    );

    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getNotifications() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETNOTIFICATION_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
    );

    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> deleteNotifications({String? notificationId}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.DELETENOTIFICATION_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      body: {'notification_id': notificationId ?? ''},
      isWantSuccessMessage: true,
    );

    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getSmsStatus({String? newValue, String? mtagID}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETSMSSTATUS_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {'New_Value': newValue ?? '', 'mtag_id': mtagID ?? ''},
    );

    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getDlinkOptions() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETDLINKOPTIONS_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
    );

    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> deleteAccount({String? comments}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
        apiUrl: ApplicationUrl.DELETEACCOUNT_URL,
        apiRequestMethod: APIREQUESTMETHOD.POST,
        isWantSuccessMessage: true,
        body: {"Comments": comments ?? ''});

    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> delinkVehicle({String? mtagID, String? rDesc, String? rID}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.DELINK_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {"MTagId": mtagID, "R_Desc": rDesc, "R_Id": rID},
    );
    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getTollHistory({String? endDate, String? startDate, String? mtagID, int? pageNo}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETALLTARNSACTIONS_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {"End_Date": endDate ?? "", "Start_Date": startDate ?? "", "mTagID": mtagID, "pageNumber": pageNo ?? 1},
    );

    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getMotorWays() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETMOTORWAYS_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
    );

    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getStations({int? mwid}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
        apiUrl: ApplicationUrl.GETMOTOSTATIONS_URL,
        apiRequestMethod: APIREQUESTMETHOD.POST,
        isWantSuccessMessage: true,
        body: dio.FormData.fromMap({'mwid': mwid ?? 1}));

    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> calCulateToll({
    int? id,
    int? entry,
    int? exit,
  }) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
        apiUrl: ApplicationUrl.TOLLCALCULATE_URL,
        apiRequestMethod: APIREQUESTMETHOD.POST,
        isWantSuccessMessage: true,
        body: dio.FormData.fromMap({
          'type': id,
          'entry': entry,
          'exit': exit,
        }));

    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> updateUserEmail({String? email, String? fullName, String? password}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.UPDATEMAIL_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
      body: {"Email": email ?? '', "Fullname": fullName ?? '', "Password": password ?? ''},
    );
    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: true);
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
      apiUrl: ApplicationUrl.FEEDBACKURL,
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
        'dateOfIssue': AuthenticationUtil.formatedDateToDD(DateTime.now()),
        'submissionDate': AuthenticationUtil.formatedDateToDD(DateTime.now()),
        'remarks': remarks,
      }),
    );
    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.CUSTOMERDETAILS_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
    );
    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getActivities() async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GEACTIVITIES_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      isWantSuccessMessage: true,
    );
    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getRechargeDetails({required String? cr, required String? uID, String? itoken}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETREACHARGE_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      body: {"CR": cr, "U_ID": uID, "ITOKEN_NO": itoken ?? ''},
      isWantSuccessMessage: true,
    );
    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getTransacDetails({required String? cr, required String? uID, String? itoken}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETRNSDETAILS_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      body: {"CR": cr, "U_ID": uID, "ITOKEN_NO": itoken},
      isWantSuccessMessage: true,
    );
    return await apiObject.requestAPI(isShowLoading: true, isCheckAuthorization: true);
  }

  Future<Map<String, dynamic>> getOwnerRechargeDetails(
      {required String? mtagId, required String? payId, String? amount}) async {
    APISTRUCTURE apiObject = APISTRUCTURE(
      apiUrl: ApplicationUrl.GETOWNERCHARGES_URL,
      apiRequestMethod: APIREQUESTMETHOD.POST,
      body: {
        "Mtag_Id": mtagId,
        "Pay_Id": payId,
        "Amount": amount,
      },
      isWantSuccessMessage: true,
    );
    return await apiObject.requestAPI(isShowLoading: false, isCheckAuthorization: true);
  }
}
