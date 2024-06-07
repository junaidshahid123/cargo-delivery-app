import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

sealed class AppUtils {
  static String selectedDate(DateTime selectedDateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDateTime);

    return formattedDate; // or display the formattedDate however you want
  }

  static String selectedTime(TimeOfDay selectedTime) {
    DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, selectedTime.hour, selectedTime.minute);
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);

    return formattedTime; // or display the formattedTime however you want
  }

  static Future showDialog(String message, Function() onPress) {
    return showCupertinoModalPopup(
      context: Get.context!,
      builder: (_) => CupertinoAlertDialog(
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: onPress,
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }
}