import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../../api/auth_controller.dart';
import 'orders_model.dart';

class OrdersLogic extends GetxController {
  ResponseModel? allRidesData;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    getAllRidesData();
  }

  Future<void> getAllRidesData() async {
    print('Get.find<AuthController>().authRepo.getAuthToken()=========${Get.find<AuthController>().authRepo.getAuthToken()}');
    final url = Uri.parse('https://thardi.com/api/allUserRides');

    // Set isLoading to true before making the request (this is where the loading starts)
    isLoading.value = true;

    try {
      // Set up headers including the token
      Map<String, String> headers = {
        'Authorization': 'Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}',
        'Content-Type': 'application/json',
      };

      // Sending GET request to the API with headers
      final response = await http.get(url, headers: headers);

      // Checking if the response is successful
      if (response.statusCode == 200) {
        // Decoding the JSON response
        final Map<String, dynamic> data = json.decode(response.body);

        // Print the raw data received from the server
        print('Raw data received from server: $data');

        // Parsing status safely
        int status = data['status'] ?? 0;

        // Safely parse the allRides field
        List<AllRide>? rides = [];
        if (data['allRides'] is List) {
          rides = (data['allRides'] as List<dynamic>)
              .map((rideData) => AllRide.fromJson(rideData))
              .toList();
        }

        // Initialize MdAllRides with the parsed data
        allRidesData = ResponseModel(
          status: status,
          allRides: rides,
        );

        // Log the address if it's available
        if (allRidesData?.allRides?.isNotEmpty == true) {
          print(allRidesData!.allRides![0].request!.receiverAddress);
          print(allRidesData!.allRides![0].request!.parcelAddress);
        }

        // Update the UI
        update();
      } else {
        // Handle the error if the response is not successful
        print('Failed to load rides data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions, like network errors
      print('Error: $e');
    }

    // Set isLoading to false after the request is complete (either success or failure)
    isLoading.value = false;
  }
}
