import 'dart:io';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/controller/request_ridecontroller.dart';
import 'package:cargo_delivery_app/widgets/contact_field.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../alltrips/controller/delivery_controller.dart';
import '../widgets/auto_place_textfield.dart';

// ignore: must_be_immutable
class DeliveryDetailsScreen extends StatefulWidget {
  const DeliveryDetailsScreen({super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  DeliveryController deliveryController = Get.put(DeliveryController());
  var fromCity = Rx<String?>(null);

  var toCity = Rx<String?>(null);

  List<XFile> pickedImage = [];

  final _parcelLoc = TextEditingController(),
      _receiverLoc = TextEditingController(),
      _receiverMob = TextEditingController();

  final _countryCode = Rx<String>('+996');

  final _parcelLat = Rx<String>('0.0');

  final _receiverLat = Rx<String>('0.0');

  final _parcelLan = Rx<String>('0.0');

  final _receiverLan = Rx<String>('0.0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<DeliveryController>(
            init: DeliveryController(),
            builder: (deliveryController) {
              return Container(
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                      textcyanColor,
                      textcyanColor.withOpacity(0.1)
                    ])),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Add Your Details for delivery".tr,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: curvedBlueColor),
                        ),
                        SizedBox(height: 20.h),
                        InkWell(
                          onTap: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.h),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                child: Image.file(
                                  File('${pickedImage[index].path}'),
                                  height: 50,
                                  width: 50,
                                ),
                              );
                            },
                            itemCount: pickedImage.length,
                          ),
                        ),
                        Text("Add Picture *".tr,
                            style: TextStyle(
                                fontSize: 16.sp, color: textBrownColor)),
                        SizedBox(height: 10.h),
                        InkWell(
                          onTap: () async {
                            var image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              pickedImage.add(image);
                            }
                            if (mounted) setState(() {});
                          },
                          child: Image.asset(
                            "assets/images/add_pic.png",
                            height: 51.h,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        AutoCompleteField(
                          hintText: 'Parcel Location'.tr,
                          controller: _parcelLoc,
                          getPlaceDetailWithLatLng: (p0) {
                            _parcelLat.value = p0.lat ?? '0.0';
                            _parcelLan.value = p0.lng ?? '0.0';
                          },
                          itemClick: (p0) {
                            return _parcelLoc.text = p0.description ?? '';
                          },
                        ),
                        SizedBox(height: 20.h),
                        AutoCompleteField(
                          hintText: 'Receiver Location'.tr,
                          controller: _receiverLoc,
                          getPlaceDetailWithLatLng: (p0) {
                            _receiverLat.value = p0.lat ?? '0.0';
                            _receiverLan.value = p0.lng ?? '0.0';
                          },
                          itemClick: (p0) {
                            return _receiverLoc.text = p0.description ?? '';
                          },
                        ),
                        SizedBox(height: 40.h),
                        ContactField(
                          onchange: (value) => _countryCode.value = value,
                          controller: _receiverMob,
                        ),
                        SizedBox(height: 40.h),
                        Obx(
                          () => Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  deliveryController.toggleDropDown();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: deliveryController
                                                  .showDropDown.value ==
                                              true
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(13),
                                              topRight: Radius.circular(13))
                                          : BorderRadius.circular(13)),
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Select Vehicle Category'.tr,
                                            style: TextStyle(
                                                color: Color(0xffBCA37F)),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              deliveryController.showDropDown.value == true
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(13),
                                              bottomLeft: Radius.circular(13))),
                                      height: 100,
                                      child: deliveryController
                                                  .mdGetVehicleCategories ==
                                              null
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: Color(0xffBCA37F),
                                              ),
                                            )
                                          : ListView.builder(
                                              padding: EdgeInsets.all(0),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    deliveryController
                                                        .tapOnVehicle(index);
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: deliveryController
                                                                    .mdGetVehicleCategories!
                                                                    .categories![
                                                                        index]
                                                                    .id ==
                                                                deliveryController
                                                                    .selectedVehicleId
                                                                    .value
                                                            ? Color(0xffBCA37F)
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    13))),
                                                    margin: EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 5,
                                                        left: 20,
                                                        right: 20),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          child: Text(
                                                              deliveryController
                                                                  .mdGetVehicleCategories!
                                                                  .categories![
                                                                      index]
                                                                  .name!),
                                                        )),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Image.network(
                                                            'http://delivershipment.com/uploads/${deliveryController.mdGetVehicleCategories!.categories![index].image}',
                                                            errorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              return buildErrorWidget(
                                                                  context,
                                                                  exception); // Return a generic Widget
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: deliveryController
                                                  .mdGetVehicleCategories!
                                                  .categories!
                                                  .length,
                                            ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            deliveryController.selectDate(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            width: MediaQuery.of(context).size.width,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text(
                                    deliveryController
                                            .dateController.text.isNotEmpty
                                        ? deliveryController.dateController.text
                                        : 'Please Select Delivery Date'.tr,
                                    style: TextStyle(color: Color(0xffBCA37F)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        CustomButton(
                            buttonText: "Submit".tr,
                            onPress: () {
                              Get.find<RequestRideController>()
                                  .createRideRequest(
                                      parcel_city: "lahore",
                                      image: pickedImage
                                          .map((xFile) => File(xFile.path))
                                          .toList(),
                                      category_id:
                                          deliveryController
                                              .selectedVehicleId
                                              .toString(),
                                      delivery_date:
                                          deliveryController
                                              .dateController.text,
                                      parcelLat: _parcelLat.value,
                                      parcelLong: _parcelLan.value,
                                      parcel_address: _parcelLoc.text,
                                      receiveLat: _receiverLat.value,
                                      receiverLong: _receiverLan.value,
                                      receiverAddress: _receiverLoc.text,
                                      receiverMob: _countryCode.value +
                                          _receiverMob.text);
                            })
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  Widget buildErrorWidget(BuildContext context, Object exception) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Text(
        'Image Not Available',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 7,
        ),
        maxLines: 1,
      ),
    ); // Return any Widget you want to display on error
  }
}
