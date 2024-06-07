import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

buildDialog({
  bool? isDelete,
  String? title,
  String? subtitle,
  void Function()? onTapOk,
  void Function()? onTap,
}) {
  return showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
            contentPadding: EdgeInsets.all(16.h),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            titleTextStyle: TextStyle(
                fontSize: 14.sp,
                color: isDelete == true ? Colors.red : textBrownColor),
            backgroundColor: Colors.white,
            title: Center(child: Text(title ?? '')),
            content: Text(
              '$subtitle',
              textAlign: TextAlign.center,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    borderRadius: 8,
                    height: 30,
                    width: 40,
                    buttonText: 'NO'.tr,
                    onPress: onTap ?? () {},
                  ),
                  CustomButton(
                    buttonColor: isDelete == true ? Colors.red : textBrownColor,
                    borderRadius: 8,
                    height: 30,
                    width: 40,
                    buttonText: 'YES'.tr,
                    onPress: onTapOk ?? () {},
                  )
                ],
              ),
            ],
          ));
}
