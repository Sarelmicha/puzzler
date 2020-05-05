import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/ui/screens/create_game_screen.dart';
import 'package:puzzlechat/ui/screens/lobby_screen.dart';
import 'package:puzzlechat/ui/screens/login_screen.dart';
import 'package:puzzlechat/ui/screens/signup_screen.dart';
import 'package:puzzlechat/ui/screens/splash_screen.dart';

class NavigatorHelper {

  static void navigateToCreateGameScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CreateGameScreen();
    }));
  }
  
  static void navigateToLobbyScreen(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LobbyScreenParent();
    }));
  }
  
  static void navigateToSignupScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignupPageParent();
    }));
  }

  static void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginScreenParent();
    }));
  }

  static void navigateToSplashScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SplashScreen();
    }));
  }

  static void navigateBackToCurrentScreen(BuildContext context) {
    Navigator.pop(context);
  }
  
}