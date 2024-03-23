import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(
              0,
              0.1,
            ),
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
                title: 'Notifications',
                isTitle: true,
                onTap: () => Get.back(),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Recent',
                style: TextStyle(fontSize: 16.sp, color: textcyanColor),
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
                            children: [
                              const Align(
                                  alignment: Alignment.topRight,
                                  child: Text('7 min ago')),
                              const Text(
                                  textAlign: TextAlign.justify,
                                  maxLines: 2,
                                  'Now you can send anything anywhere in a very low cost'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('SAR 74.67'),
                                  SizedBox(
                                    width: 20.h,
                                  ),
                                  const Text(
                                    'SAR 56.56',
                                    textWidthBasis: TextWidthBasis.parent,
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough),
                                  )
                                ],
                              )
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
