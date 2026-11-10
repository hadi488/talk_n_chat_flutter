import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final String hintText;
  final dynamic onChanged;
  const EmailTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      onChanged: (value) {
        onChanged(value);
      },
      style: TextStyle(color: Colors.black),
      decoration: kInputDecoration.copyWith(hintText: hintText),
    );
  }
}
