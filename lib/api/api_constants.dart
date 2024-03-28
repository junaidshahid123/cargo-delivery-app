// ignore_for_file: non_constant_identifier_names, constant_identifier_names
const BASE_URL = '';
List<Map<int, String>> API_ERROR_RESPONSE = [
  {200: ResponseType.REQUEST_SUCCESSFULL},
  {400: ResponseType.BAD_REQUEST},
  {401: ResponseType.Unauthorized},
  {403: ResponseType.Forbidden},
  {404: ResponseType.NOT_FOUND},
  {405: ResponseType.Method_Not_Allowed},
  {406: ResponseType.Not_Acceptable},
  {409: ResponseType.Conflict},
  {413: ResponseType.Request_Entity_Too_Large},
  {415: ResponseType.Unsupported_Media_Type},
  {500: ResponseType.Internal_Server_Error},
  {501: ResponseType.Not_Implemented},
  {503: ResponseType.Service_Unavailable},
  {507: ResponseType.Insufficient_Storage},
  {509: ResponseType.Bandwidth_Limit_Exceeded}
];

class APIREQUESTMETHOD {
  static const String POST = "Post";
  static const String GET = "Get";
  static const String PUT = "Put";
  static const String DELETE = "Delete";
  // static const String REQUEST = "Request";
}

class APIEXCEPTION {
  static String SOCKET = "Socket Exception \n Please Try again";
  static String HTTP = "Http Exception\n Please Try again";
  static String FORMAT = "Format Exception\n Please Try again later";
  static String UNKNOWN = "Unknown Exception\n Please Try again later";
}

class ResponseType {
  static String REQUEST_SUCCESSFULL = "REQUEST_SUCCESSFUL";
  static String BAD_REQUEST = "BAD_REQUEST";
  static String Unauthorized = "Unauthorized";
  static String Forbidden = "Forbidden";
  static String NOT_FOUND = "NOT_FOUND";
  static String Method_Not_Allowed = "Method_Not_Allowed";
  static String Not_Acceptable = "Not_Acceptable";
  static String Conflict = "Conflict";
  static String Request_Entity_Too_Large = "Request_Entity_Too_Large";
  static String Unsupported_Media_Type = "Unsupported_Media_Type";
  static String Internal_Server_Error = "Internal_Server_Error";
  static String Not_Implemented = "Not_Implemented";
  static String Service_Unavailable = "Service_Unavailable";
  static String Insufficient_Storage = "Insufficient_Storage";
  static String Bandwidth_Limit_Exceeded = "Bandwidth_Limit_Exceeded";
}

class APIRESPONSE {
  static String? GetErrorResponse(int errorCode) {
    Map<int, String> responseError = API_ERROR_RESPONSE.firstWhere((error) => error.containsKey(errorCode));
    return responseError[errorCode];
  }

  static String SUCCESS = "Success";
  static String ERROR = "Error";
  static String EXCEPTION = "Exception";
}
