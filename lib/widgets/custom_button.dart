import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPress;
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double? borderRadius;
  const CustomButton(
      {Key? key,
      this.buttonColor,
      this.buttonTextColor,
      this.width,
      this.height,
      this.borderRadius,
      required this.buttonText,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 55.h,
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            color: buttonColor ?? textBrownColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 13)),
        child: FittedBox(
          child: Text(buttonText,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: buttonTextColor ?? Colors.white)),
        ),
      ),
    );
  }
}
