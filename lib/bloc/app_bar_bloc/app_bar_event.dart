import 'package:equatable/equatable.dart';
import 'package:puzzlechat/data/contact.dart';

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

  final List<Contact> userContacts;

  NotificationButtonHasBeenPressed({this.userContacts});

  @override
  List<Object> get props => null;
}

class PressedOnIconFinished extends AppBarEvent {
  @override
  List<Object> get props => throw null;

}