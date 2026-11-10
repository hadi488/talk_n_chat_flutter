import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/widgets/rectangular_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = '/welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController colorController;
  late Animation animation;
  late Animation colorAnimation;

  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 25),
      upperBound: 1.0,
      lowerBound: 0.2,
    );
    colorController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 25),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    colorAnimation = ColorTween(
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(colorController);

    controller.forward();
    colorController.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('complete ${controller.status}');
        controller.reverse(from: 1.0);
        controller.stop();
      } else if (status == AnimationStatus.dismissed) {
        print('dismissed ${controller.status}');
        controller.forward();
      }
    });
    colorController.addListener(() {
      setState(() {});
    });
    controller.addListener(() {
      print('Value: ${animation.value}');
      print('Elapsed: ${controller.lastElapsedDuration}');
      setState(() {});
    });
  }

  void dispose() {
    controller.dispose();
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/logo.png'),
                    height: animation.value * 100,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      speed: Duration(milliseconds: 200),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 48.0),
            RectangularButton(
              text: "Log In",
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              color: Colors.lightBlueAccent,
            ),
            SizedBox(height: 8.0),
            RectangularButton(
              text: "Register",
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
