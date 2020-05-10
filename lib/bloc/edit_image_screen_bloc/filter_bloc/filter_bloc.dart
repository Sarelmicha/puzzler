import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_state.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/filter_bloc/filter_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/filter_bloc/filter_state.dart';
import 'package:puzzlechat/data/filter.dart';


class FilterBloc
    extends Bloc<EditImageScreenEvent, EditImageScreenState> {

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

  FilterBloc({this.imageFile});



  @override
  EditImageScreenState get initialState => EditImageScreenInitialState();

  @override
  Stream<EditImageScreenState> mapEventToState(
      EditImageScreenEvent event) async* {
    print('event issss $event');

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
  }


}
