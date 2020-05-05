

import 'package:flutter/material.dart';

const kLoginId = '/login';
const kSignupId = '/signup';
const kSplashId = "/splash";
const kGameId = '/game';
const kLobbyId = '/lobby';
const kCreateGameId = '/creategame';
const double kCardMargins = 5;
const double kCardRadius = 10.0;

const TextStyle kLabelTextStyle = TextStyle(
  color: Color(0xffbababa),
  fontSize: 12.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'RobotoMono',
);

const kTextFieldDecoration = InputDecoration(

  hintText: 'Enter a value',
  filled: true,
  fillColor: Colors.purple,
  prefixIcon: Icon(Icons.person),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  border: InputBorder.none,
);

const kPageHeaderStyle = TextStyle(
  color: Colors.purpleAccent,
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

final Shader kLinearGradient = LinearGradient(
  colors: <Color>[Colors.purpleAccent,Colors.pinkAccent],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)
);