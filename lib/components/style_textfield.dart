import 'package:flutter/material.dart';
import 'package:flutter_challenge/theme.dart';

class StyleTextField extends StatelessWidget {
  const StyleTextField(this.hint, this.controller, this.isObscureText,
      {super.key});

  final String hint;
  final TextEditingController controller;
  final isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscureText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        border: InputBorder.none,
        fillColor: textFieldBgColor,
        labelText: hint,
      ),
    );
  }
}
