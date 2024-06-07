import 'package:cargo_delivery_app/widgets/back_button_widget.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant/colors_utils.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
          children: [
            buildBackButton(
              context,
              title: 'Payments'.tr,
              isTitle: true,
              color: Colors.white,
              onTap: () => Get.back(),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: 30.h, left: 10.h, right: 10.h, bottom: 20.h),
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0.h),
                  child: Column(
                    children: [
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                   Text('Contact Information'.tr),
                                   ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.email_outlined),
                                    title: Text('sampleemail@gmail.com'),
                                    subtitle: Text('Email'.tr),
                                    trailing: Icon(Icons.edit),
                                  ),
                                   ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.phone_outlined),
                                    title: Text('+96-123-456-789'),
                                    subtitle: Text('Email'.tr),
                                    trailing: Icon(Icons.edit),
                                  ),
                                   Text('Address'.tr),
                                  ExpansionTile(
                                    childrenPadding: EdgeInsets.zero,
                                    title:  Text(
                                        'Airport Road,Al-Ryadh'.tr),
                                    children: [
                                      Image.asset('assets/images/map.png')
                                    ],
                                  ),
                                   Text('Payment Method'.tr),
                                   ExpansionTile(
                                    leading: Icon(Icons.paypal_outlined),
                                    title: Text('Debit Card'.tr),
                                    subtitle: Text('***** 0696 4629'),
                                  ),
                                   Text('Pay by receiver method'.tr),
                                  CustomTextField(
                                    fillColor: Colors.grey.shade100,
                                    controller: TextEditingController(),
                                    hintText: 'enter details'.tr,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.h),
              child: CustomButton(buttonText: 'Save Now'.tr, onPress: () {}),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }
}
