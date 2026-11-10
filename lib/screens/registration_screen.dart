import 'package:flash_chat/constants.dart';
import 'package:flash_chat/widgets/rectangular_button.dart';
import 'package:flash_chat/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = '/registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(tag: 'logo', child: kLogoContainer),
            SizedBox(height: 48.0),
            TextfieldWidget(
              hintText: 'Enter your email',
              onChanged: (value) {
                //Do something with the user input.
              },
            ),
            SizedBox(height: 8.0),
            TextfieldWidget(
              hintText: "Enter your password",
              onChanged: (value) {
                //Do something with the user input.
              },
            ),
            SizedBox(height: 24.0),
            RectangularButton(
              text: "Register",
              onPressed: () {
                //Implement registration functionality.
              },
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
