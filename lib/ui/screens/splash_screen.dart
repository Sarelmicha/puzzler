
import 'package:flutter/material.dart';
import 'package:puzzlechat/util/contstants.dart';


class SplashScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Puzzler',
          style: kLogoTextStyle.copyWith(
            foreground: Paint()..shader = kLinearGradient,
          )
        ),
      ),
    );
  }

}
