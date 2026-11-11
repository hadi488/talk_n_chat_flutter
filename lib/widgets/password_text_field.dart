import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final String hintText;
  final dynamic onChanged;
  const PasswordTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.center,
      obscureText: true,
      onChanged: (value) {
        onChanged(value);
        print('value: $value');
      },
      style: TextStyle(color: Colors.black),
      decoration: kInputDecoration.copyWith(hintText: hintText),
    );
  }
}
