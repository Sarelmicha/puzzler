import 'package:equatable/equatable.dart';

abstract class PickImageScreenEvent extends Equatable {}

class PickImageScreenScreenInitial extends PickImageScreenEvent {
  @override
  List<Object> get props => null;
}

class EnterPickImageScreenEvent extends PickImageScreenEvent {
  @override
  List<Object> get props => null;
}


class CameraPressedEvent extends PickImageScreenEvent {
  @override
  List<Object> get props => null;
}

class GalleryPressedEvent extends PickImageScreenEvent {
  @override
  List<Object> get props => null;
}
