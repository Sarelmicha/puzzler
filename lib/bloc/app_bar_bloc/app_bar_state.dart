import 'package:equatable/equatable.dart';
import 'package:puzzlechat/data/game_data.dart';

abstract class AppBarState extends Equatable{}

class AppBarInitial extends AppBarState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class LogOutSuccess extends AppBarState {

  @override
  // TODO: implement props
  List<Object> get props => null;

}

class ShowSettingsSuccess extends AppBarState {

  @override
  // TODO: implement props
  List<Object> get props => null;

}

class ShowNotificationSuccess extends AppBarState {

  final List<GameData> cardsData;

  ShowNotificationSuccess({this.cardsData});

  @override
  // TODO: implement props
  List<Object> get props => null;

}



