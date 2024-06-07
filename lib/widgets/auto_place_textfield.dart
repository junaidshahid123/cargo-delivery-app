import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

// ignore: must_be_immutable
class AutoCompleteField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  bool? obscureText;
  final Widget? prefixIconPath;
  final String? errorText;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? fillColor;
  final Color? borderColor;
  final FocusNode? focusNode;
  void Function(String)? onSubmitted;
  String? Function(String?)? validator;
  Function(Prediction)? itemClick;
  Function(Prediction)? getPlaceDetailWithLatLng;
  AutoCompleteField({
    Key? key,
    required this.controller,
    this.obscureText,
    this.onSubmitted,
    this.validator,
    this.hintText,
    this.keyboardType,
    this.maxLines,
    this.prefixIconPath,
    this.suffixIcon,
    this.errorText,
    this.textAlign,
    this.focusNode,
    this.borderColor,
    this.fillColor,
    this.itemClick,
    this.getPlaceDetailWithLatLng,
  }) : super(key: key);

  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      getPlaceDetailWithLatLng: widget.getPlaceDetailWithLatLng,
      itemClick: widget.itemClick,
      googleAPIKey: 'AIzaSyDdwlGhZKKQqYyw9f9iME40MzMgC9RL4ko',
      textEditingController: widget.controller,
      inputDecoration: InputDecoration(
        focusColor: Colors.white,
        suffixIcon: widget.obscureText != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText!;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    widget.obscureText!
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: textBrownColor,
                  ),
                ))
            : const SizedBox(),
        fillColor: widget.fillColor ?? Colors.white,
        filled: true,
        errorStyle: TextStyle(fontSize: 14.sp),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Colors.white)),
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'RadioCanada',
            fontWeight: FontWeight.w400,
            color: textBrownColor),
        contentPadding: const EdgeInsets.only(top: 16.0, left: 15, right: 15),
      ),
    );
  }
}
