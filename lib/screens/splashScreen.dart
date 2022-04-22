import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:survey/screens/welcome.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 2000,
        splash: const Image(image: AssetImage('assets/images/logo.png')),
        nextScreen: const Welcome(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        backgroundColor: Colors.white);
  }
}
