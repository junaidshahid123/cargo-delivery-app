import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../../api/auth_controller.dart';
import 'orders_model.dart';

class OrdersLogic extends GetxController {
  MDAllRides? allRidesData;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllRidesData();
  }

  Future<void> getAllRidesData() async {
    print(
        'Authorization Token: Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}');

    final url = Uri.parse('https://thardi.com/api/allUserRides');
    isLoading.value = true;

    try {
      Map<String, String> headers = {
        'Authorization':
            'Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}',
        'Content-Type': 'application/json',
      };

      final response = await http.get(url, headers: headers);

      // Step 1: Print the raw response body for debugging
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Raw data received from server: $data');

        // Step 2: Parse the data into MdAllRides
        allRidesData = MDAllRides.fromJson(data);

        // Step 3: Handle the fetched rides
        if (allRidesData!.allRides!.isNotEmpty) {
          print('Fetched ${allRidesData!.allRides!.length} rides');
          // Update your UI or state here with the 'allRidesData.allRides' list
          update();
        } else {
          print('No rides found');
        }

        isLoading.value = false;
      } else {
        // Handle error: API did not return 200 OK
        print('Failed to fetch data: ${response.statusCode}');
        isLoading.value = false;
      }
    } catch (error) {
      print('Error occurred while fetching rides data: $error');
      isLoading.value = false;
    }
  }
}
