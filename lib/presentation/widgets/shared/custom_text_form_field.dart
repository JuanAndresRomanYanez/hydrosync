import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextStyle? labelStyle;
  final TextStyle? inputTextStyle;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.labelStyle,
    this.inputTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
      ),
      style: inputTextStyle,
    );
  }
}