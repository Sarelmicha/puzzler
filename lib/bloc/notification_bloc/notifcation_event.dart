import 'package:equatable/equatable.dart';


abstract class NotificationEvent extends Equatable {}


class GameHasBeenClicked extends NotificationEvent {

  final String receiverPhoneNumber;
  final String senderPhoneNumber;
  final String gameId;

  GameHasBeenClicked({this.receiverPhoneNumber, this.senderPhoneNumber,this.gameId});

  @override
  List<Object> get props => null;
}