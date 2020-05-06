import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_event.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_state.dart';

class PickImageScreenBloc
    extends Bloc<PickImageScreenEvent, PickImageScreenState> {
  @override
  PickImageScreenState get initialState => PickImageScreenInitialState();

  @override
  Stream<PickImageScreenState> mapEventToState(
      PickImageScreenEvent event) async* {
    if (event is PickImageScreenReady) {
      yield PickImageScreenAnimationSuccess();
    } else if (event is CameraPressedEvent) {
      yield CameraSuccessState();
    } else if (event is GalleryPressedEvent) {
      yield GallerySuccessState();
    }
  }
}
