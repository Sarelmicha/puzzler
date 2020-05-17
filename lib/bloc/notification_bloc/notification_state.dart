import 'package:equatable/equatable.dart';
import 'package:puzzlechat/data/game_data.dart';

abstract class NotificationState extends Equatable {}

class NotificationInitialState extends NotificationState {
  @override
  List<Object> get props => null;

}

class NotificationScreenReady extends NotificationState {

  final List<GameData> cardsData;

  NotificationScreenReady({this.cardsData});

  @override
  List<Object> get props => null;

}
