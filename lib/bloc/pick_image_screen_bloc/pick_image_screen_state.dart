import 'dart:io';

import 'package:equatable/equatable.dart';


abstract class PickImageScreenState extends Equatable {}

class PickImageScreenInitialState extends PickImageScreenState {
  @override
  List<Object> get props => null;
}

class AnimationSuccess extends PickImageScreenState {

  @override
  List<Object> get props => null;
}

class CameraSuccessState extends PickImageScreenState {

  final File imageFile;

  CameraSuccessState({this.imageFile});

  @override
  List<Object> get props => null;

}

class GallerySuccessState extends PickImageScreenState {

  final File imageFile;

  GallerySuccessState({this.imageFile});

  @override
  List<Object> get props => null;

}