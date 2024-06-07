import 'package:cargo_delivery_app/alltrips/controller/all_trips_controller.dart';
import 'package:cargo_delivery_app/api/user_repo.dart';
import 'package:cargo_delivery_app/home/controller/location_controller.dart';
import 'package:cargo_delivery_app/home/controller/request_ridecontroller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/auth_controller.dart';
import '../api/auth_repo.dart';

class Binding extends Bindings {
  @override
  void dependencies() async {
    Get.put(
      AuthController(
        authRepo: AuthRepo(
          sharedPreferences: await SharedPreferences.getInstance(),
        ),
      ),
    );
    Get.lazyPut(() => LocationController(userRepo: UserRepo()));
    Get.lazyPut(() => RequestRideController(userRepo: UserRepo()));
    Get.lazyPut(() => AllTripsController(userRepo: UserRepo()));
  }
}
