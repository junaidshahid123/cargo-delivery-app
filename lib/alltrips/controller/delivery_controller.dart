import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../model/MDGetVehicleCategories.dart';
import '../../model/user_model.dart';

class DeliveryController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVehicleCategories();
  }

  RxString selectedVehicleId = '0'.obs;
  RxString selectedVehicleName = '-1'.obs;
  MDGetVehicleCategories? mdGetVehicleCategories;
  RxBool showDropDown = false.obs;
  DateTime? _selectedDate;
  final TextEditingController dateController = TextEditingController();

  tapOnVehicle(int index) {
    selectedVehicleId.value = mdGetVehicleCategories!.categories![index].id!;
    selectedVehicleName.value =
        mdGetVehicleCategories!.categories![index].name!;
    showDropDown.value = !showDropDown.value;

    update();
  }

  toggleDropDown() {
    showDropDown.value = !showDropDown.value;
    update();
  }

  Future<Map<String, dynamic>> getVehicleCategories() async {
    final url = Uri.parse('https://thardi.com/api/getAllCategory');
    HttpOverrides.global = MyHttpOverrides();

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        "Authorization": "Bearer${UserModel().token}"
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(
          'This is jsonResponse in getVehicleCategories=========${jsonResponse}');
      mdGetVehicleCategories = MDGetVehicleCategories.fromJson(jsonResponse);
      update();
      return jsonResponse;
    } else {
      throw Exception('Failed to load getVehicleCategories');
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      dateController.text = "${picked.toLocal()}".split(' ')[0];
    }
    update();
    print('dateController=====${dateController.text}');
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
