import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'notification_logic.dart';

import 'package:intl/intl.dart'; // Don't forget to import the intl package

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (controller) {
          // Check if the data is loaded
          if (controller.mdNotifications == null) {
            // You can show a loading indicator here
            return Center(child: CircularProgressIndicator());
          }

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
                      title: 'Notifications'.tr,
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
                      'Recent'.tr,
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
                              (context, index) {
                                // Retrieve the notification data from the controller
                                final notification =
                                    controller.mdNotifications?.data?[index];

                                if (notification == null)
                                  return SizedBox.shrink();

                                // Format the date to display year, month, and day
                                String formattedDate = '';
                                if (notification.createdAt != null) {
                                  try {
                                    DateTime dateTime =
                                        DateTime.parse(notification.createdAt!);
                                    formattedDate = DateFormat('yyyy-MM-dd')
                                        .format(dateTime);
                                  } catch (e) {
                                    // If the date is not in the correct format, use a default value
                                    formattedDate = 'Invalid Date';
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
                                    children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(formattedDate)),
                                      Row(
                                        children: [
                                          Text(
                                              textAlign: TextAlign.justify,
                                              maxLines: 2,
                                              notification.message ??
                                                  'No message'.tr),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(notification.page ?? 'N/A'),
                                          SizedBox(
                                            width: 20.h,
                                          ),
                                          Text(
                                            'SAR 74.67'.tr,
                                            textWidthBasis:
                                                TextWidthBasis.parent,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              childCount:
                                  controller.mdNotifications?.data?.length ?? 0,
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
        });
  }
}

// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<NotificationController>(
//         init: NotificationController(),
//         builder: (controller) {
//           return Scaffold(
//             body: Container(
//               height: MediaQuery.sizeOf(context).height,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: const Alignment(
//                     0,
//                     0.1,
//                   ),
//                   colors: [
//                     textcyanColor.withOpacity(0.8),
//                     textcyanColor.withOpacity(0.1),
//                     textcyanColor.withOpacity(0.1),
//                     textcyanColor.withOpacity(0.1),
//                   ],
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8.0.h),
//                     child: buildBackButton(
//                       context,
//                       title: 'Notifications'.tr,
//                       isTitle: true,
//                       onTap: () => Get.back(),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30.h,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Recent'.tr,
//                       style: TextStyle(fontSize: 16.sp, color: textcyanColor),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0.h),
//                       child: CustomScrollView(
//                         shrinkWrap: true,
//                         slivers: [
//                           SliverList(
//                             delegate: SliverChildBuilderDelegate(
//                                   (context, index) => Container(
//                                 margin: const EdgeInsets.all(2),
//                                 padding: const EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   color: const Color(0xffFFFFFF),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Align(
//                                         alignment: Alignment.topRight,
//                                         child: Text('7 min ago'.tr)),
//                                     Text(
//                                         textAlign: TextAlign.justify,
//                                         maxLines: 2,
//                                         'Now you can send anything anywhere in a very low cost'
//                                             .tr),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Text('SAR 74.67'.tr),
//                                         SizedBox(
//                                           width: 20.h,
//                                         ),
//                                         Text(
//                                           'SAR 74.67'.tr,
//                                           textWidthBasis: TextWidthBasis.parent,
//                                           style: TextStyle(
//                                               decoration:
//                                               TextDecoration.lineThrough),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
