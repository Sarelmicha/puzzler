import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/ui/widgets/icon_text_field.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/contstants.dart';
import 'package:puzzlechat/util/operation.dart';

class SignupScreen extends StatelessWidget {
  static String id = kSignupId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.purpleAccent, Colors.pinkAccent])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "It's free and only takes a minute",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              IconTextField(
                hint: "Enter your name",
                obscureText: false,
                textInputType: TextInputType.text,
                iconData: Icons.person,
                padding: EdgeInsets.all(10),
              ),
              IconTextField(
                hint: "Enter your email",
                obscureText: false,
                textInputType: TextInputType.text,
                iconData: Icons.email,
                padding: EdgeInsets.all(10),
              ),
              IconTextField(
                hint: "Enter your password",
                obscureText: true,
                textInputType: TextInputType.visiblePassword,
                iconData: Icons.lock,
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                text: 'Sign Up',
                width: 200,
                height: 42,
                onPressed: () {
                  Navigator.pushNamed(context, kWaitingId,
                      arguments: {'operation': Operation.SIGNUP});
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
