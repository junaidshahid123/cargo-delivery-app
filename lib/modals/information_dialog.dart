import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';

class InformationDialog extends StatelessWidget {
  const InformationDialog({
    super.key,
    required this.title,
    this.buttonTitle = 'Ok',
  });

  final String title;
  final String buttonTitle;

  Future<void> show() async {
    await showDialog(context: Get.context!, builder: (_) => this);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      titleTextStyle: TextStyle(fontSize: 14.sp),
      backgroundColor: Colors.white,
      content: Text(title, style: const TextStyle(color: Colors.black)),
      actions: [
        CustomButton(
          borderRadius: 8,
          height: 30,
          width: 80,
          buttonText: buttonTitle,
          onPress: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
