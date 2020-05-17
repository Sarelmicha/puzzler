import 'package:flutter/cupertino.dart';
import 'package:puzzlechat/data/game_data.dart';

class User {

  User({@required this.phoneNumber, @required this.games, this.active});

  //User Phone Number
  String phoneNumber;

  //Active user or not
  bool active;

  //Map of all open games with other users.
  Map<String,List<GameData>> games;

}