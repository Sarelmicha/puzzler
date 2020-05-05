import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_event.dart';
import 'package:puzzlechat/bloc/login_bloc/login_state.dart';
import 'package:puzzlechat/ui/screens/signup_screen.dart';
import 'package:puzzlechat/ui/screens/splash_screen.dart';
import 'package:puzzlechat/ui/widgets/form_widget.dart';
import 'package:puzzlechat/ui/widgets/icon_text_field.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'lobby_screen.dart';



class LoginScreenParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {

    loginBloc = BlocProvider.of<LoginBloc>(context);

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
                'Puzzler',
                style: GoogleFonts.greatVibes(
                    color: Colors.white,
                    fontSize: 55.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoadinState) {
                    navigateToSplashScreen(context);
                  }
                  else if (state is LoginSuccessState) {
                    navigateToLobbyScreen(context, state.user);
                  }
                  else if (state is LoginFailureState) {
                    navigateBackToLoginScreen(context);
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                     if (state is LoginFailureState) {
                      return Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              SizedBox(width: 10.0),
              FormWidget(
                emailController: emailController,
                passwordController: passwordController,
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                text: "Login",
                width: 200,
                height: 42,
                onPressed: () {
                  loginBloc.add(LoginButtonPressedEvent(
                    email: emailController.text,
                    password: passwordController.text,
                  ));
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
                  navigateToSignUpScreen(context);
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignupPageParent();
    }));
  }

  void navigateBackToLoginScreen(BuildContext context) {
    Navigator.pop(context);
  }

  void navigateToLobbyScreen(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LobbyScreen(currentUser: user);
    }));
  }

  void navigateToSplashScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SplashScreen();
    }));
  }
}
