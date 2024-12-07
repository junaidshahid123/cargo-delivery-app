// ignore_for_file: library_prefixes

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cargo_delivery_app/home/controller/location_controller.dart';
import 'package:dio/dio.dart' as apiClient;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_data.dart';

import '../../api/api_constants.dart';
import 'api_loader.dart';
import 'auth_controller.dart';

class APISTRUCTURE {
  final String apiUrl;
  dynamic body;
  final bool isWantSuccessMessage;
  final String apiRequestMethod;
  String? contentType;
  late Dio dio;

  APISTRUCTURE({
    this.body,
    required this.apiUrl,
    required this.apiRequestMethod,
    this.isWantSuccessMessage = false,
    this.contentType,
  });

  Future<Map<String, dynamic>> requestAPI(
      {bool isShowLoading = false, bool isCheckAuthorization = true}) async {
    String api = "";

    if (isShowLoading) {
      ApiLoader.show();
      print("Loading started");
    }

    try {
      api = BASE_URL + apiUrl;
      print("API URL: $api");

      Map<String, String> header = {};

      if (contentType != null) {
        header.addAll({"Content-Type": contentType!});
        print("Content-Type header: ${contentType!}");
      }

      if (isCheckAuthorization) {
        String? authToken = Get.find<AuthController>().authRepo.getAuthToken();
        header.addAll({
          "Accept": "application/json",
          "Authorization": "Bearer $authToken"
        });
        print('Authorization header added');
      } else {
        header.addAll({"Accept": "application/json"});
      }

      print('Request Headers: $header');

      apiClient.Dio dio = apiClient.Dio();
      apiClient.Options options = apiClient.Options(
        followRedirects: false,
        headers: header,
        validateStatus: (int? status) {
          return (status ?? 500) < 600;
        },
      );

      apiClient.Response<dynamic> response =
          apiRequestMethod == APIREQUESTMETHOD.GET
              ? await dio.get(api, options: options)
              : apiRequestMethod == APIREQUESTMETHOD.POST
                  ? await dio.post(api, data: body, options: options)
                  : apiRequestMethod == APIREQUESTMETHOD.DELETE
                      ? await dio.delete(api, options: options)
                      : await dio.put(api, data: body, options: options);

      print('$api response:[${response.statusCode}]----> $response');

      if (isShowLoading) {
        ApiLoader.hide();
        print("Loading hidden");
      }

      if (response.statusCode == 200) {
        print("Response status code 200, returning data");
        return {APIRESPONSE.SUCCESS: response.data};
      }

      Map<String, dynamic> responseResult = {};
      if (response.statusCode != null) {
        responseResult = response.data;
      } else {
        responseResult = {APIRESPONSE.ERROR: "Something went wrong".tr};
      }

      print("Error response: $responseResult");
      return responseResult;
    } on SocketException {
      if (isShowLoading) {
        ApiLoader.hide();
        print("Loading hidden due to SocketException");
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
      print("Caught SocketException, returning error");
      return {APIRESPONSE.EXCEPTION: APIEXCEPTION.SOCKET};
    } on HttpException {
      if (isShowLoading) {
        ApiLoader.hide();
        print("Loading hidden due to HttpException");
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
      print("Caught HttpException, returning error");
      return {APIRESPONSE.EXCEPTION: APIEXCEPTION.HTTP};
    } on FormatException {
      if (isShowLoading) {
        ApiLoader.hide();
        print("Loading hidden due to FormatException");
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
      print("Caught FormatException, returning error");
      return {APIRESPONSE.EXCEPTION: APIEXCEPTION.FORMAT};
    } on apiClient.DioException catch (e) {
      Map<String, dynamic> exception = {};

      if (isShowLoading) {
        ApiLoader.hide();
        print("Loading hidden due to DioException");
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

      print("Caught DioException, type: ${e.type}, message: ${e.message}");

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
          print('Dio Error: $exception');
          if (e.response != null) {
            print('Response Body: ${e.response?.data}');
          }
          print('Request: ${e.requestOptions.uri}');
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
        print("Loading hidden due to general exception");
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
          content: Text(error.toString().contains("SocketException")
              ? "Internet Connection Error"
              : error.toString()),
        ),
      );
      print("Caught generic exception: $error");

      return error.toString().contains("SocketException")
          ? {APIRESPONSE.EXCEPTION: "Internet Connection Error"}
          : {APIRESPONSE.EXCEPTION: APIEXCEPTION.UNKNOWN};
    }
  }
}

sealed class MQTTClient {
  static const String _MQTT_BASE_URL = "mqtt-dashboard.com";
  static final client = MqttServerClient.withPort(
    _MQTT_BASE_URL,
    "USER-APP",
    1883,
  );

  static void _onConnected() {
    log('channel is Connected connected');
  }

  static void _onSubscribed(String topic) {
    log('Subscription confirmed for topic $topic');
  }

  static Future<void> mqttForUser(String driverId) async {
    client.setProtocolV311();
    client.logging(on: true);
    client.keepAlivePeriod = 120;
    client.autoReconnect = true;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      log(e.toString());
      await client.connect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.onSubscribed = _onSubscribed;

      debugPrint('connected');
    } else {
      client.connect();
    }

    client.subscribe('ride_user_request_$driverId', MqttQos.atLeastOnce);
    client.subscribe('ride_request_status_$driverId', MqttQos.atLeastOnce);

    client.updates?.listen((c) async {
      final payload = MqttPublishPayload.bytesToStringAsString(
        (c[0].payload as MqttPublishMessage).payload.message,
      );
      final rideStatus = RideStatusModel.fromJson(jsonDecode(payload));
      if (rideStatus.driverLocation != null) {
        final icon = await Get.find<LocationController>().getBytesFromAsset(
          'assets/images/truck_icon.png',
        );
        Get.find<LocationController>().addDriverMarker(
          LatLng(
            rideStatus.driverLocation!.latitude,
            rideStatus.driverLocation!.longitude,
          ),
          icon,
        );
      }
    });

    client.onConnected = _onConnected;
  }

  static void emitLocation(LocationModel location, String driverId) async {
    log(
      'Emitting Message for driver : $driverId, Coordinates are ${location.toString()}.',
    );
    client.publishMessage(
      'ride_user_request_$driverId',
      MqttQos.atLeastOnce,
      RideStatusModel(userLocation: location).toJson().convertMapToUint8Buffer,
    );
  }
}

class RideStatusModel {
  RideStatusModel({
    this.status = 'Accepted',
    this.userLocation,
    this.driverLocation,
  });

  final String status;
  final LocationModel? userLocation;
  final LocationModel? driverLocation;

  factory RideStatusModel.fromJson(Map<String, dynamic> json) {
    final userLocation = json['user_location'];
    final driverLocation = json['driver_location'];
    return RideStatusModel(
      userLocation:
          userLocation == null ? null : LocationModel.fromJson(userLocation),
      driverLocation: driverLocation == null
          ? null
          : LocationModel.fromJson(driverLocation),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ride_status': status,
      'user_location': userLocation?.toJson(),
      'driver_location': driverLocation?.toJson(),
    };
  }
}

class LocationModel {
  LocationModel({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  @override
  String toString() {
    return 'LocationModel(latitude: $latitude, longitude: $longitude)';
  }
}

extension _MapParseExtension on Map<String, dynamic> {
  Uint8Buffer get convertMapToUint8Buffer {
    final jsonString = jsonEncode(this);

    final byteList = utf8.encode(jsonString);
    final uint8buffer = Uint8Buffer();
    uint8buffer.addAll(byteList);

    return uint8buffer;
  }
}
