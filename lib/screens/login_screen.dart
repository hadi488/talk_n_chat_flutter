import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/password_text_field.dart';
import 'package:flash_chat/widgets/rectangular_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/email_text_field.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void updateState({bool isLoading = false}) {
    _isLoading = isLoading;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(tag: 'logo', child: kLogoContainer),
              ),
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
                  print('value: $value');
                },
              ),
              SizedBox(height: 24.0),
              RectangularButton(
                text: 'Log In',
                onPressed: () async {
                  try {
                    updateState(isLoading: true);
                    final userCredential = await _auth
                        .signInWithEmailAndPassword(
                          email: _email,
                          password: _password,
                        );
                    if (userCredential.user != null) {
                      print('User logged in: ${userCredential.user?.email}');
                      _email = '';
                      _password = '';
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    updateState(isLoading: false);
                  } catch (e) {
                    print('Error logging in: $e');
                  }
                },
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
