import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/ui/screens/signup_screen.dart';
import 'package:puzzlechat/ui/screens/waiting_screen.dart';
import 'package:puzzlechat/ui/widgets/icon_text_field.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/contstants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzlechat/util/operation.dart';

class LoginScreen extends StatelessWidget {
  static String id = kLoginId;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Puzzler',
                    style: GoogleFonts.greatVibes(
                        color: Colors.white,
                        fontSize: 55.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
              SizedBox(
                height: 10.0,
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
                textInputType: TextInputType.text,
                iconData: Icons.lock,
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                text: "Login",
                width: 200,
                height: 42,
                onPressed: () {
                  Navigator.pushNamed(
                      context,
                      WaitingScreen.id,
                      arguments: {
                        'operation' : Operation.LOGIN,
                      },
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Text(
                  "Don't have an account? Signup",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context,
                    SignupScreen.id
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
