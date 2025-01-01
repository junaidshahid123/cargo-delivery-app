import 'dart:convert';

import 'package:get/get.dart';

import '../api/auth_controller.dart';
import 'notification_model.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  MDNotifications? mdNotifications;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllNotifications();
  }

  Future<void> getAllNotifications() async {
    print(
        'Authorization Token: Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}');

    final url = Uri.parse('https://thardi.com/api/notificationList');
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
        mdNotifications = MDNotifications.fromJson(data);

        // Step 3: Handle the fetched rides
        if (mdNotifications!.data!.isNotEmpty) {
          print('Fetched ${mdNotifications!.data!.length} mdNotifications');
          // Update your UI or state here with the 'allRidesData.allRides' list
          update();
        } else {
          print('No Notifications found');
        }

        isLoading.value = false;
      } else {
        // Handle error: API did not return 200 OK
        print('Failed to fetch data: ${response.statusCode}');
        isLoading.value = false;
      }
    } catch (error) {
      print('Error occurred while fetching notifications data: $error');
      isLoading.value = false;
    }
  }
}
