import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  const RectangularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          minWidth: kMaterialButMinWidth,
          height: kMaterialButHeight,
          child: Text(text),
        ),
      ),
    );
  }
}
