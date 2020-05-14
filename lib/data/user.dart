import 'package:flutter/cupertino.dart';

class User {

  User({@required this.phoneNumber, @required this.newGames, this.active});

  String phoneNumber;
  bool active;
  Map<String,Object> newGames;

}