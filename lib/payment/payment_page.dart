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
              title: 'Payments',
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
                                  const Text('Contact Information'),
                                  const ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.email_outlined),
                                    title: Text('sampleemail@gmail.com'),
                                    subtitle: Text('Email'),
                                    trailing: Icon(Icons.edit),
                                  ),
                                  const ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.phone_outlined),
                                    title: Text('+96-123-456-789'),
                                    subtitle: Text('Email'),
                                    trailing: Icon(Icons.edit),
                                  ),
                                  const Text('Address'),
                                  ExpansionTile(
                                    childrenPadding: EdgeInsets.zero,
                                    title: const Text(
                                        'Airport Road,  Al-Ryadh   '),
                                    children: [
                                      Image.asset('assets/images/map.png')
                                    ],
                                  ),
                                  const Text('Payment Method'),
                                  const ExpansionTile(
                                    leading: Icon(Icons.paypal_outlined),
                                    title: Text('Debit Card'),
                                    subtitle: Text('***** 0696 4629'),
                                  ),
                                  const Text('Pay by receiver method'),
                                  CustomTextField(
                                    fillColor: Colors.grey.shade100,
                                    controller: TextEditingController(),
                                    hintText: 'enter details',
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
              child: CustomButton(buttonText: 'Save Now', onPress: () {}),
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
