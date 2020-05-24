import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/filter.dart';


abstract class EditImageScreenState extends Equatable {}


class EditImageScreenInitialState extends EditImageScreenState {
  @override
  List<Object> get props => null;
}

class StickerBottomScreenSuccessState extends EditImageScreenState {
  @override
  List<Object> get props => null;
}

class FiltersBottomScreenSuccessState extends EditImageScreenState {

  final List<Filter> filters;
  FiltersBottomScreenSuccessState({this.filters});

  @override
  List<Object> get props => null;

}

class ParametersBottomScreenSuccessState extends EditImageScreenState {
  @override
  List<Object> get props => null;
}


class SendImageSuccessState extends EditImageScreenState {

  @override
  List<Object> get props => null;

}

//class EditImageWaitingState extends EditImageScreenState {
//  @override
//  List<Object> get props => null;
//
//}


class SendImageFailureState extends EditImageScreenState {

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

class ChangeParametersSuccessState extends EditImageScreenState {
  @override
  // TODO: implement props
  List<Object> get props => null;


}


