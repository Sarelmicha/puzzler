import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzlechat/data/filter.dart';

abstract class EditImageScreenState extends Equatable {}

class EditImageScreenInitialState extends EditImageScreenState {
  @override
  List<Object> get props => null;
}

class RotationSuccessState extends EditImageScreenState {
  @override
  List<Object> get props => throw UnimplementedError();

}

class AddStickerSuccessState extends EditImageScreenState {
  @override
  List<Object> get props => null;
}


class AddParametersSuccessState extends EditImageScreenState {
  @override
  List<Object> get props => null;
}

class AddFiltersSuccessState extends EditImageScreenState {

  final List<Filter> filters;
  AddFiltersSuccessState({this.filters});

  @override
  List<Object> get props => null;

}

class SendImageSuccessState extends EditImageScreenState {

  @override
  List<Object> get props => null;

}

class SendImageFailureState extends EditImageScreenState {

  @override
  List<Object> get props => null;

}

class ImageFilterSuccessState extends EditImageScreenState {

  final List<Filter> filters;
  final int currentColor;

  ImageFilterSuccessState({@required this.currentColor,@required this.filters});

  @override
  List<Object> get props => null;

}

class ChangeTimerSuccessState extends EditImageScreenState {

  final int totalTime;

  ChangeTimerSuccessState({@required this.totalTime});

  @override
  List<Object> get props => null;

}

class ChangePiecesSuccessState extends EditImageScreenState {

  final int numOfPieces;

  ChangePiecesSuccessState({@required this.numOfPieces});

  @override
  List<Object> get props => null;

}


