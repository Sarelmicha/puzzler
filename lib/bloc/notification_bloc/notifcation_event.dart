import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:puzzlechat/data/game_data.dart';


abstract class NotificationEvent extends Equatable {}


class GameHasBeenClicked extends NotificationEvent {

  final GameData gameData;
  final FirebaseUser currentUser;

  GameHasBeenClicked({this.gameData, this.currentUser});

  @override
  List<Object> get props => null;
}