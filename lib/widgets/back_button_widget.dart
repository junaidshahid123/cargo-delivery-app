import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

Widget buildBackButton(BuildContext context,
    {Callback? onTap,
    String? title,
    bool? isTitle,
    bool? isAction,
    Color? color}) {
  return Padding(
    padding: EdgeInsets.only(top: 50.0.h, left: 30.w),
    child: Row(
      mainAxisAlignment: (isTitle == true && isAction == true)
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 100.w,
        ),
        if (isTitle == true)
          Text(
            title ?? '',
            style: TextStyle(color: color ?? textcyanColor, fontSize: 16.sp),
          ),
        if (isAction == true) const Icon(Icons.search)
      ],
    ),
  );
}
