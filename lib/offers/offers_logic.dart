import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../api/auth_controller.dart';
import 'offers_model.dart';

class OffersLogic extends GetxController {
  List<MDAllOffers>? mdAllOffers;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllOffers();
  }

  Future<void> getAllOffers() async {
    // Log the authorization token for debugging
    print(
        'Authorization Token: Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}');

    final url = Uri.parse('https://thardi.com/api/userOffers');
    isLoading.value = true;

    try {
      // Define headers for the HTTP request
      Map<String, String> headers = {
        'Authorization':
        'Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}',
        'Content-Type': 'application/json',
      };

      // Send the GET request
      final response = await http.get(url, headers: headers);

      // Print the raw response body for debugging
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Try to decode the response
        try {
          final List<dynamic> data = json.decode(response.body);
          print('Parsed data received from server: $data');

          // Parse the data into MDAllOffers list
          mdAllOffers = data
              .map((item) => MDAllOffers.fromJson(item as Map<String, dynamic>))
              .toList();

          // Log the number of offers fetched
          if (mdAllOffers != null && mdAllOffers!.isNotEmpty) {
            print('Fetched ${mdAllOffers!.length} offers');
            update(); // Notify GetX to rebuild the widgets
          } else {
            print('No offers found');
          }
        } catch (e) {
          print('Error parsing data: $e');
        }
      } else {
        // Log error status code and message
        print('Failed to fetch data: ${response.statusCode}');
        print('Response message: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the HTTP request
      print('Error occurred while fetching data: $error');
    } finally {
      // Ensure loading state is updated regardless of success or failure
      isLoading.value = false;
    }
  }
}
