import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:puzzlechat/data/game_data.dart';

abstract class NotificationState extends Equatable {}

class NotificationInitialState extends NotificationState {
  @override
  List<Object> get props => null;

}

class GameStartedState extends NotificationState {

  final Uint8List image;
  final String totalTime;
  final String numOfRows;

  GameStartedState({this.image, this.totalTime, this.numOfRows});

  @override
  List<Object> get props => null;

}

class NotificationWaitingState extends NotificationState {
  @override
  List<Object> get props => null;

}




