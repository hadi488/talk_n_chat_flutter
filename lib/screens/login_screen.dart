import 'package:flash_chat/constants.dart';
import 'package:flash_chat/widgets/password_text_field.dart';
import 'package:flash_chat/widgets/rectangular_button.dart';
import 'package:flutter/material.dart';

import '../widgets/email_text_field.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
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
            EmailTextField(
              hintText: 'Enter your email',
              onChanged: (value) {
                _email = value;
              },
            ),
            SizedBox(height: 8.0),
            PasswordTextField(
              hintText: 'Enter your password.',
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(height: 24.0),
            RectangularButton(
              text: 'Log In',
              onPressed: () {
                print('Email: $_email, Password: $_password');
              },
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
