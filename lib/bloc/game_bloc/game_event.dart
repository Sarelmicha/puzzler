import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {}


class GameStartedEvent extends GameEvent {

  @override
  List<Object> get props => null;

}

class GameIsReadyEvent extends GameEvent {
  @override
  List<Object> get props => null;

}

class CellHasBeenFieldEvent extends GameEvent {

  final int index;

  CellHasBeenFieldEvent({this.index});

  @override
  List<Object> get props => null;
}

class TimeHasPassedEvent extends GameEvent {

  @override
  List<Object> get props => null;
}

class PlayButtonHasBeenPressedEvent extends GameEvent {

  @override
  List<Object> get props => null;

}

