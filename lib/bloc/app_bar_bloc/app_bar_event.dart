import 'package:equatable/equatable.dart';

abstract class AppBarEvent extends Equatable{}

class AppStartedEvent extends AppBarEvent {
  @override
  List<Object> get props => null;
}

class LogoutButtonHasBeenPressed extends AppBarEvent {
  @override
  List<Object> get props => null;
}

class SettingsButtonHasBeenPressed extends AppBarEvent {
  @override
  List<Object> get props => null;
}

class NotificationButtonHasBeenPressed extends AppBarEvent {
  @override
  List<Object> get props => null;
}