import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';



class ContactField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String value)? onchange;
  final String? hintText; // Property for hint text
  final double? hintTextFontSize; // Property for hint text font size
  final Color? hintTextColor; // Property for hint text color
  final FocusNode? focusNode; // Property for focus node

  const ContactField({
    Key? key,
    this.controller,
    this.validator,
    this.onchange,
    this.hintText, // Optional hint text
    this.hintTextFontSize, // Optional font size
    this.hintTextColor, // Optional hint text color
    this.focusNode, // Optional focus node
  }) : super(key: key);

  @override
  _ContactFieldState createState() => _ContactFieldState();
}

class _ContactFieldState extends State<ContactField> {
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13),
              bottomLeft: Radius.circular(13),
            ),
            color: Colors.white,
          ),
          child: CountryCodePicker(
            backgroundColor: Colors.white,
            onChanged: (value) {
              if (widget.onchange != null) {
                widget.onchange!(value.dialCode.toString());
              }
            },
            initialSelection: '+966',
            textStyle: TextStyle(color: Colors.brown), // Assuming `textBrownColor` is brown
            showFlag: false,
            padding: EdgeInsets.zero,
          ),
        ),
        Flexible(
          child: TextFormField(
            focusNode: _internalFocusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            controller: widget.controller,
            onFieldSubmitted: (value) {
              _internalFocusNode.unfocus(); // Unfocus the text field when user is done inputting
            },
            decoration: InputDecoration(
              hintText: widget.hintText ?? "123456789", // Use the passed hint text or default
              counterText: '',
              contentPadding: const EdgeInsets.all(1),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
                borderSide: BorderSide.none,
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
                borderSide: BorderSide.none,
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              errorStyle: const TextStyle(height: 0.05),
              hintStyle: TextStyle(
                fontSize: widget.hintTextFontSize ?? 16, // Use provided font size or default
                color: widget.hintTextColor ?? Colors.grey, // Use provided color or default to grey
              ),
            ),
          ),
        ),
      ],
    );
  }
}
