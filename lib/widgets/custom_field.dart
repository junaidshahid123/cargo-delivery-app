import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
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

  CustomTextField({
    Key? key,
    required this.controller,
    this.obscureText,
    this.onSubmitted,
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
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 51.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(13)),
        child: TextFormField(
          textInputAction: TextInputAction.done,
          focusNode: widget.focusNode,
          maxLines: widget.maxLines,
          onFieldSubmitted: widget.onSubmitted,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.errorText;
            }
            return null;
          },
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          obscureText: widget.obscureText ?? false,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
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
            contentPadding:
                const EdgeInsets.only(top: 16.0, left: 15, right: 15),
          ),
          textAlign: widget.textAlign ?? TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
        ));
  }
}
