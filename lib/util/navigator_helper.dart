import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/data/contact.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/ui/screens/edit_image_screen.dart';
import 'package:puzzlechat/ui/screens/game_screen.dart';
import 'package:puzzlechat/ui/screens/notification_screen.dart';
import 'package:puzzlechat/ui/screens/pick_image_screen.dart';
import 'package:puzzlechat/ui/screens/lobby_screen.dart';
import 'package:puzzlechat/ui/screens/login_screen.dart';
import 'package:puzzlechat/ui/screens/sms_code_screen.dart';
import 'package:puzzlechat/ui/screens/splash_screen.dart';

class NavigatorHelper {
  static void navigateToPickImageScreen(BuildContext context,
      String receiverPhoneNumber, FirebaseUser currentUser) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PickImageScreenParent(
          receiverPhoneNumber: receiverPhoneNumber, currentUser: currentUser);
    }));
  }

  static void navigateToEditImageScreen(BuildContext context, File imageFile,
      String receiverPhoneNumber, FirebaseUser currentUser) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditImageScreenParent(
          imageFile: imageFile,
          receiverPhoneNumber: receiverPhoneNumber,
          currentUser: currentUser);
    }));
  }

  static void navigateToLobbyScreen(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LobbyScreenParent(currentUser: user);
    }));
  }

  static void navigateToSMSCodeScreenScreen(
      BuildContext context, String verificationId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SMSCodeScreenParent(
        verificationId: verificationId,
      );
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

  static void navigateBackToPreviousScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToGameScreenScreen(
      BuildContext context, Uint8List image, int totalTime, int numOfRows,FirebaseUser currentUser) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return GameScreenParent(
          image: image, totalTime: totalTime, numOfRows: numOfRows,currentUser: currentUser);
    }));
  }

  static void navigateToGameNotificationScreen(BuildContext context,
      List<GameData> cardsData, FirebaseUser currentUser) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NotificationScreenParent(
          cardsData: cardsData, currentUser: currentUser);
    }));
  }
}
