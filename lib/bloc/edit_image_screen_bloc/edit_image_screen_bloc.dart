import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_state.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_event.dart';
import 'package:puzzlechat/repository/game_repository.dart';

import '../../data/filter.dart';
import 'edit_image_screen_event.dart';
import 'edit_image_screen_state.dart';
import 'image_bloc/image_event.dart';

class EditImageScreenBloc
    extends Bloc<EditImageScreenEvent, EditImageScreenState> {
  GameRepository _gameRepository;
  File imageFile;
  BuildContext context;

  EditImageScreenBloc(File imageFile) {
    this._gameRepository = GameRepository();
    this.imageFile = imageFile;
  }

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

  List<int> times = [
    30,
    60,
    90,
    120,
  ];

  List<int> pieces = [9, 16, 25, 36];

  int currentTimeIndex = 0;
  int currentPiecesIndex = 0;
  int currentImageRotation = 0;

  @override
  EditImageScreenState get initialState => EditImageScreenInitialState();

  @override
  Stream<EditImageScreenState> mapEventToState(
      EditImageScreenEvent event) async* {
    print('event is $event');

    if (event is ParametersButtonHasBeenPressed) {
      yield ParametersBottomScreenSuccessState();
    } else if (event is FiltersButtonHasBeenPressed) {
      List<Filter> filters = createFilterList();
      yield FiltersBottomScreenSuccessState(filters: filters);
    } else if (event is TimerRightButtonHasBeenPressed) {
      if (currentTimeIndex == times.length - 1) {
        currentTimeIndex = -1;
      }
      yield ChangeTimerSuccessState(totalTime: times[++currentTimeIndex]);
    } else if (event is TimerLeftButtonHasBeenPressed) {
      if (currentTimeIndex == 0) {
        currentTimeIndex = times.length;
      }
      yield ChangeTimerSuccessState(totalTime: times[--currentTimeIndex]);
    } else if (event is PiecesRightButtonHasBeenPressed) {
      if (currentPiecesIndex == pieces.length - 1) {
        currentPiecesIndex = -1;
      }
      yield ChangePiecesSuccessState(numOfPieces: pieces[++currentPiecesIndex]);
    } else if (event is PiecesLeftButtonHasBeenPressed) {
      if (currentPiecesIndex == 0) {
        currentPiecesIndex = pieces.length;
      }
      yield ChangePiecesSuccessState(numOfPieces: pieces[--currentPiecesIndex]);
    } else if (event is SendButtonHasBeenPressed) {

      print('sender phone number is ${event.senderPhoneNumber}');

      _gameRepository.sendGame(
          event.receiverPhoneNumber,
          convertImageToByteData(imageFile),
          event.totalTime,
          event.numOfPieces,
          event.senderPhoneNumber);
      yield SendImageSuccessState();

    } else if (event is ParameterChangedEvent) {
      yield ChangeParametersSuccessState();
    }
  }

  List<Filter> createFilterList() {
    int numOfFilters = 8;
    List<Filter> filters = [];
    List<String> filterNames = [
      'No Filter',
      'Classic',
      'Retro',
      'Sphinex',
      'Ruby',
      'Clipperd',
      'Saphir',
      "Clean"
    ];
    List<bool> isPickedList = [
      true,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];

    List<ImageEvent> events = [
      NoFilterHasBeenPressed(),
      ClassicHasBeenPressed(),
      RetroHasBeenPressed(),
      SphinexHasBeenPressed(),
      RubyHasBeenPressed(),
      ClipperdHasBeenPressed(),
      SaphirHasBeenPressed(),
      CleanHasBeenPressed(),
    ];

    for (int i = 0; i < numOfFilters; i++) {
      filters.add(Filter(
        imageFile: imageFile,
        isPicked: isPickedList[i],
        filterName: filterNames[i],
        endColor: endColors[i],
        event: events[i],
      ));
    }

    return filters;
  }

  Uint8List convertImageToByteData(File imageFile) {
    var byteData = imageFile.readAsBytesSync();
    return byteData;
  }
}
