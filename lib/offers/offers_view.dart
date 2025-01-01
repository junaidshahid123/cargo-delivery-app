import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

import '../constant/colors_utils.dart';
import '../widgets/back_button_widget.dart';
import 'offers_logic.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersLogic>(
      init: OffersLogic(),
      builder: (logic) {
        // Display loading indicator if data is still being fetched
        if (logic.mdAllOffers == null || logic.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Filter non-null offers
        final filteredOffers =
            logic.mdAllOffers?.where((offer) => offer != null).toList();

        return Scaffold(
          body: Container(
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, 0.1),
                colors: [
                  textcyanColor.withOpacity(0.8),
                  textcyanColor.withOpacity(0.1),
                  textcyanColor.withOpacity(0.1),
                  textcyanColor.withOpacity(0.1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: buildBackButton(
                    context,
                    title: 'Offers'.tr,
                    isTitle: true,
                    onTap: () => Get.back(),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: CustomScrollView(
                      shrinkWrap: true,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              // Retrieve the offer data
                              final offer = filteredOffers?[index];

                              // Safeguard against null offer
                              if (offer == null) return SizedBox.shrink();

                              // Format the date for display
                              String formattedDate = 'Invalid Date';
                              if (offer.createdAt != null) {
                                try {
                                  DateTime dateTime =
                                      DateTime.parse(offer.createdAt!);
                                  formattedDate =
                                      DateFormat('yyyy-MM-dd').format(dateTime);
                                } catch (e) {
                                  print('Date parsing error: $e');
                                }
                              }

                              return Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xffFFFFFF),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(formattedDate),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${'From:'.tr} ${offer.from ?? 'N/A'}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        Text(
                                          '${'To:'.tr} ${offer.to ?? 'N/A'}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${'Date:'.tr} ${offer.date ?? 'N/A'}',
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        Text(
                                          '${'Time:'.tr} ${offer.time ?? 'N/A'}',
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      '${'Price:'.tr} SAR ${offer.price ?? 'N/A'}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount: filteredOffers?.length ?? 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
