import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';



class ContactField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String value)? onchange;

  const ContactField({
    Key? key,
    this.controller,
    this.validator,
    this.onchange,
  }) : super(key: key);

  @override
  _ContactFieldState createState() => _ContactFieldState();
}

class _ContactFieldState extends State<ContactField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
                  bottomLeft: Radius.circular(13)),
              color: Colors.white),
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
            focusNode: _focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            controller: widget.controller,
            onFieldSubmitted: (value) {
              _focusNode.unfocus(); // Unfocus the text field when user is done inputting
            },
            decoration: const InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.all(1),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(13),
                      bottomRight: Radius.circular(13)),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(13),
                      bottomRight: Radius.circular(13)),
                  borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(13),
                      bottomRight: Radius.circular(13)),
                  borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(13),
                      bottomRight: Radius.circular(13)),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              hintText: "123456789",
              errorStyle: TextStyle(height: 0.05),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}
