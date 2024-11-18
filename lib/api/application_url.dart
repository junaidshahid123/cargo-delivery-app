// ignore_for_file: non_constant_identifier_names, constant_identifier_names
class ApplicationUrl {
  static const String _BASE_URL = 'https://thardi.com/api';

  // static const String _BASE_URL = 'http://delivershipment.com/api';
  static const String _IMAGE_ULR = 'https://thardi.com';

  static String get IMAGE_ULR => _IMAGE_ULR;
  static const String _LOGIN_URL = '$_BASE_URL/login';

  static String get LOGIN_URL => _LOGIN_URL;
  static const String _UPDATEUSER_URL = '$_BASE_URL/updateUser';
  static const String _PAYMENTMETHOD_URL = '$_BASE_URL/paymentMethodList';
  static const String _ACCEPTOFFER_URL = '$_BASE_URL/acceptOffer';

  static String get UPDATEUSER_URL => _UPDATEUSER_URL;

  static String get PAYMENTMETHOD_URL => _PAYMENTMETHOD_URL;
  static String get ACCEPTOFFER => _ACCEPTOFFER_URL;
  static const String _VERIFYOTP_URL = '$_BASE_URL/verifyOTP';

  static String get VERIFYOTP_URL => _VERIFYOTP_URL;
  static const String _GENERATEOTP_URL = '$_BASE_URL/generateOTP_6';

  static String get GENERATEOTP_URL => _GENERATEOTP_URL;
  static const String _GETALLCATEGORIES_URL = '$_BASE_URL/dashboardRequest';

  static String get GETALLCATEGORIES_URL => _GETALLCATEGORIES_URL;
  static const String _GETALLUSERTRIPS_URL = '$_BASE_URL/allTrips';

  static String get GETALLUSERTRIPS_URL => _GETALLUSERTRIPS_URL;
  static const String _GETBANNERS_URL = '$_BASE_URL/getBanners';

  static String get GETBANNERS_URL => _GETBANNERS_URL;
  static const String _RESETPASS_URL = '$_BASE_URL/reset';

  static String get RESETPASS_URL => _RESETPASS_URL;
  static const String _REGISTER_URL = '$_BASE_URL/register';

  static String get REGISTER_URL => _REGISTER_URL;
  static const String _CONFIRMLOCATION_URL = '$_BASE_URL/setLocation';

  static String get CONFIRMLOCATION_URL => _CONFIRMLOCATION_URL;
  static const String _LOGOUT_URL = '$_BASE_URL/logout';

  static String get LOGOUT_URL => _LOGOUT_URL;
  static const String _DELETEUSER_URL = '$_BASE_URL/deleteUser';

  static String get DELETEUSER_URL => _DELETEUSER_URL;
  static const String _CREATERIDEREQUEST_URL = '$_BASE_URL/createRequest';

  static String get CREATERIDEREQUEST_URL => _CREATERIDEREQUEST_URL;
  static const String _RIDEREQUESTS_URL = '$_BASE_URL/offerList';

  static String get RIDEREQUESTS_URL => _RIDEREQUESTS_URL;
  static const String _ACEPTRIDEREQUESTS_URL = '$_BASE_URL/acceptOffer';

  static String get ACEPTRIDEREQUESTS_URL => _ACEPTRIDEREQUESTS_URL;
//offerList
}
