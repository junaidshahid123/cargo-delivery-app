import 'package:cargo_delivery_app/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant/colors_utils.dart';

class AllTripsPage extends StatelessWidget {
  const AllTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0.5, 0.5),
            colors: [
              textcyanColor,
              textcyanColor.withOpacity(0.1),
              textcyanColor.withOpacity(0.1),
              textcyanColor.withOpacity(0.1)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: buildBackButton(
                context,
                isAction: true,
                isTitle: false,
                onTap: () => Get.back(),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Text(
                'All TRIPS',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16.sp,
                    color: textcyanColor),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0.h),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xffFFFFFF),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Muhammad'),
                                  Text('Trip ID: 5475')
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Makkah ',
                                    style: TextStyle(color: textBrownColor)),
                                const TextSpan(
                                    text: ' to ',
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: ' Madina',
                                    style: TextStyle(color: textBrownColor))
                              ])),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(' Earning: SAR 74.67'),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
