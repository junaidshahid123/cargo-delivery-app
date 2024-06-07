import 'package:cargo_delivery_app/alltrips/trips_model.dart';
import 'package:cargo_delivery_app/api/api_constants.dart';
import 'package:cargo_delivery_app/api/user_repo.dart';
import 'package:get/get.dart';

class AllTripsController extends GetxController implements GetxService {
  final UserRepo userRepo;
  AllTripsController({required this.userRepo});
  var allTripsMode = Rx<AllTripsModel?>(null);
  Future<void> getAllUserTrips() async {
    var response = await userRepo.getAllUsersTrips();
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      allTripsMode.value =
          AllTripsModel.fromJson(response[APIRESPONSE.SUCCESS]);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    Future.wait([getAllUserTrips()]);
  }
}
