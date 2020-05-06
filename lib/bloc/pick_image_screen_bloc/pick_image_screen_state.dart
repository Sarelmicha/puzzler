import 'dart:io';

import 'package:equatable/equatable.dart';


abstract class PickImageScreenState extends Equatable {}

class PickImageScreenInitialState extends PickImageScreenState {
  @override
  List<Object> get props => null;
}

class PickImageScreenAnimationSuccess extends PickImageScreenState {

  @override
  List<Object> get props => null;
}

class CameraSuccessState extends PickImageScreenState {

  File imageFile;

  CameraSuccessState({this.imageFile});

  @override
  List<Object> get props => null;

}

class GallerySuccessState extends PickImageScreenState {

  File imageFile;

  GallerySuccessState({this.imageFile});

  @override
  List<Object> get props => null;

}