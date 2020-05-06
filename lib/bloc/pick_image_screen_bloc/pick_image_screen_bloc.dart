import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_event.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_state.dart';

class PickImageScreenBloc
    extends Bloc<PickImageScreenEvent, PickImageScreenState> {
  @override
  PickImageScreenState get initialState => PickImageScreenInitialState();

  @override
  Stream<PickImageScreenState> mapEventToState(
      PickImageScreenEvent event) async* {
    if (event is EnterPickImageScreenEvent) {
      yield AnimationSuccess();
    } else if (event is CameraPressedEvent){
      File imageFile = await _openCamera();
      yield CameraSuccessState(imageFile: imageFile);

    } else if (event is GalleryPressedEvent) {
      File imageFile = await _openGallery();
      yield GallerySuccessState(imageFile: imageFile);
    }
  }

  Future<File> _openCamera() async{

    return  await ImagePicker.pickImage(source: ImageSource.camera);

  }

  Future<File> _openGallery() async {

   return await ImagePicker.pickImage(source: ImageSource.gallery);

  }
}
