import 'package:flutter/material.dart';
import 'package:flutter_challenge/theme.dart';

class StyleTextField extends StatelessWidget {
  const StyleTextField(this.hint, {super.key});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        border: InputBorder.none,
        fillColor: textFieldBgColor,
        labelText: hint,
      ),
    );
  }
}
