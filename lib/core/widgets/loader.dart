import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_messaging/constants/constants.dart';

class MyLoader extends StatelessWidget {
  const MyLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCube(color: context.primaryColor, size: 50.0),
    );
  }
}
