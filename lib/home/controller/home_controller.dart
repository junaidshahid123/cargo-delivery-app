import 'package:cargo_delivery_app/api/api_constants.dart';
import 'package:cargo_delivery_app/api/user_repo.dart';
import 'package:cargo_delivery_app/home/riderrequest/model/current_ride_model.dart';
import 'package:cargo_delivery_app/model/banner_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController implements GetxService {
  final UserRepo userRepo;

  HomeController({required this.userRepo});

  var bannerModel = Rx<BannersModel?>(null);
  var dasboardModel = Rx<DashBoardModel?>(null);

  Future getCategories() async {
    var response = await userRepo.getCategories();
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      dasboardModel.value =
          DashBoardModel.fromMap(response[APIRESPONSE.SUCCESS]);
      print('dasboardModel.value======${dasboardModel.value!.currentRides.length}');
    }
  }

  Future getBanners() async {
    var response = await userRepo.getBanners();
    bannerModel.value = BannersModel.fromJson(response[APIRESPONSE.SUCCESS]);
  }

  @override
  void onReady() async {
    super.onReady();
    Future.wait(
      [getBanners(), getCategories()],
    );
  }
}
