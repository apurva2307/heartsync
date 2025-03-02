import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:my_messaging/constants/constants.dart';

showSplashScreen(BuildContext context) {
  return FlutterSplashScreen.scale(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [context.primaryColor, context.secondaryColor],
    ),
    childWidget: SizedBox(height: 50, child: Image.asset("assets/logo.png")),
    duration: const Duration(milliseconds: 1500),
    animationDuration: const Duration(milliseconds: 1000),
    onAnimationEnd: () => debugPrint("On Scale End"),
    // nextScreen: const MyHomePage(),
  );
}
