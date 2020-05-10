import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_state.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/rotation_bloc/rotation_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/rotation_bloc/rotation_state.dart';
import 'package:puzzlechat/data/filter.dart';



class RotationBloc
    extends Bloc<EditImageScreenEvent, EditImageScreenState> {

  static const int MAX_ROTATION = 3;
  static const int MIN_ROTATION = -1;
  int currentImageRotation = MIN_ROTATION;


  @override
  EditImageScreenState get initialState => EditImageScreenInitialState();

  @override
  Stream<EditImageScreenState> mapEventToState(
      EditImageScreenEvent event) async* {
      print('event is $event');

     if (event is RotateButtonHasBeenPressed) {
      if (currentImageRotation == MAX_ROTATION) {
        currentImageRotation = -1;
      }
      yield RotationSuccessState(rotation: ++currentImageRotation);
    }
  }
}
