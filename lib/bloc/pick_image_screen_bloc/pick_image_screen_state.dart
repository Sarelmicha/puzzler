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

class BackFromCameraSuccess extends PickImageScreenState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class BackFromGallerySuccess extends PickImageScreenState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

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