import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_state.dart';



class ImageInitialState extends ImageState{
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class SelectFilterSuccessState extends ImageState {

  final int currentColor;

  SelectFilterSuccessState({@required this.currentColor});

  @override
  List<Object> get props => null;

}

class ChangeFilterSuccessState extends ImageState {
  @override
  List<Object> get props => null;

}

class RotationInitialState extends ImageState {


  @override
  List<Object> get props => throw UnimplementedError();

}

class RotationSuccessState extends ImageState {

  final int rotation;

  RotationSuccessState({this.rotation});

  @override
  List<Object> get props => null;

}

class FinishedRotationState extends ImageState {
  @override
  List<Object> get props => null;

}
