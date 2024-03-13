import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactField extends StatefulWidget {
  final TextEditingController? controller;
  const ContactField({Key? key, this.controller}) : super(key: key);

  @override
  State<ContactField> createState() => _ContactFieldState();
}

class _ContactFieldState extends State<ContactField> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.only(left: 2, right: 19),
        height: 51.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(13)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CountryCodePicker(
              textStyle: TextStyle(color: textBrownColor),
              showFlag: false,
              padding: EdgeInsets.zero,
            ),
            SizedBox(
              width: w * 0.02,
            ),
            const VerticalDivider(),
            SizedBox(
              width: w * 0.05,
            ),
            SizedBox(
              height: 45,
              width: w * 0.5,
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "123456789",
                  hintStyle: TextStyle(fontSize: 16, color: textBrownColor),
                ),
              ),
            )
          ],
        ));
  }
}
