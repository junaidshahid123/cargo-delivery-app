import 'dart:async';
import 'dart:developer';

import 'package:cargo_delivery_app/api/api_constants.dart';
import 'package:cargo_delivery_app/api/user_repo.dart';
import 'package:cargo_delivery_app/apputils.dart';
import 'package:cargo_delivery_app/home/driver_tracking_screen.dart';
import 'package:cargo_delivery_app/home/riderrequest/model/offer_model.dart';

import 'package:get/get.dart';

import '../../../api/api_structure.dart';

class RideRequestsController extends GetxController implements GetxService {
  final UserRepo userRepo;

  RideRequestsController({required this.userRepo});

  var requests = Rx<OffersModel?>(null);

  Future<void> getOffersList() async {
    try {
      final response = await userRepo.getOffersList();
      if (response.containsKey(APIRESPONSE.SUCCESS)) {
        requests.value = OffersModel.fromJson(response[APIRESPONSE.SUCCESS]);
      }
    } catch (_) {}
  }

  acceptDriverRequest({
    required String requestId,
    required String offerId,
    required String amount,
    required String card,
    String? description,
    required String driverId,
  }) async {
    try {
      log('Driver ID : $driverId');
      final response = await userRepo.acceptDriverRequest(
        requestId: requestId,
        offerId: offerId,
        amount: amount,
        card: card,
      );
      if (response.containsKey(APIRESPONSE.SUCCESS)) {
        MQTTClient.mqttForUser(driverId);
        if (timer != null) timer!.cancel();
        // Get.to(() => const DriverTrackingScreen(shouldEmitLocation: true));
      } else {
        AppUtils.showDialog(response['message'], () => Get.back());
      }
    } catch (_) {}
  }

  Timer? timer;

  @override
  void onReady() {
    getOffersList();
    //
    // timer = Timer.periodic(const Duration(seconds: 50), (_) {
    //   getOffersList();
    // });
    super.onReady();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer?.cancel();
    }
    super.onClose();
  }
}
