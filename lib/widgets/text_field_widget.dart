import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final String hintText;
  final dynamic onChanged;
  const TextfieldWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        //Do something with the user input.
      },
      style: TextStyle(color: Colors.black),
      decoration: kInputDecoration.copyWith(hintText: hintText),
    );
  }
}
