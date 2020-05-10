import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_bloc/image_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_bloc/image_state.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_state.dart';


class ImageBloc
    extends Bloc<ImageEvent, ImageState> {

  static const int MAX_ROTATION = 3;
  static const int MIN_ROTATION = -1;
  int currentImageRotation = MIN_ROTATION;

  File imageFile;

  List<int> endColors = [
    0xffffffff,
    0xffe6e1e0,
    0xffc4b8b5,
    0xaac4b8b5,
    0xffd699d4,
    0xffceb1ab,
    0x77c4b8b5,
    0xfff4edec
  ];

  ImageBloc({this.imageFile});



  @override
  ImageState get initialState => ImageInitialState();

  @override
  Stream<ImageState> mapEventToState(
      ImageEvent event) async* {

      if (event is NoFilterHasBeenPressed) {
      yield SelectFilterSuccessState(
          currentColor: endColors[0]);
    } else if (event is ClassicHasBeenPressed) {
      yield SelectFilterSuccessState(
          currentColor: endColors[1]);
    } else if (event is RetroHasBeenPressed) {
      yield SelectFilterSuccessState(
          currentColor: endColors[2]);
    } else if (event is SphinexHasBeenPressed) {
      yield SelectFilterSuccessState(
          currentColor: endColors[3]);
    } else if (event is RubyHasBeenPressed) {
      yield SelectFilterSuccessState(
          currentColor: endColors[4]);
    } else if (event is ClipperdHasBeenPressed) {
      yield SelectFilterSuccessState(
          currentColor: endColors[5]);
    } else if (event is SaphirHasBeenPressed) {
      yield SelectFilterSuccessState(
          currentColor: endColors[6]);
    } else if (event is CleanHasBeenPressed) {
      yield SelectFilterSuccessState(
          currentColor: endColors[7]);
    } else if (event is FilterChangedEvent) {
        yield ChangeFilterSuccessState();
      }
    else if (event is RotateButtonHasBeenPressed) {
      print('current image rotation is $currentImageRotation');
      if (currentImageRotation == MAX_ROTATION) {
        currentImageRotation = -1;
      }
      yield RotationSuccessState(rotation: ++currentImageRotation);
    } else if( event is RotationChangedEvent) {
      yield FinishedRotationState();
      }
  }


}
