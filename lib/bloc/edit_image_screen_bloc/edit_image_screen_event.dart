import 'package:equatable/equatable.dart';

abstract class EditImageScreenEvent extends Equatable {}

class EditImageScreenScreenInitial extends EditImageScreenEvent {
  @override
  List<Object> get props => null;
}


class ParametersButtonHasBeenPressed extends EditImageScreenEvent {
  @override
  List<Object> get props => null;
}

class FiltersButtonHasBeenPressed extends EditImageScreenEvent {

  @override
  List<Object> get props => null;
}


class StickersButtonHasBeenPressed extends EditImageScreenEvent {
  @override
  List<Object> get props => null;
}

class SendButtonHasBeenPressed extends EditImageScreenEvent {

  final String receiverPhoneNumber;
  final int totalTime;
  final int numOfPieces;
  final String senderPhoneNumber;
  final int currentRotation;
  final int currentColor;

  SendButtonHasBeenPressed({this.receiverPhoneNumber,this.totalTime, this.numOfPieces, this.senderPhoneNumber,this.currentRotation,this.currentColor});

  @override
  List<Object> get props => null;
}



class TimerRightButtonHasBeenPressed extends EditImageScreenEvent {
  @override
  List<Object> get props => null;
}


class TimerLeftButtonHasBeenPressed extends EditImageScreenEvent {
  @override
  List<Object> get props => null;
}

class PiecesLeftButtonHasBeenPressed extends EditImageScreenEvent {
  @override
  List<Object> get props => null;
}

class PiecesRightButtonHasBeenPressed extends EditImageScreenEvent {
  @override
  List<Object> get props => null;
}

class ParameterChangedEvent extends EditImageScreenEvent {
  @override
  List<Object> get props => null;

}






