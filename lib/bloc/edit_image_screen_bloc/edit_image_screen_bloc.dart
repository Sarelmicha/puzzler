import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_state.dart';
import 'package:puzzlechat/data/filter.dart';

class EditImageScreenBloc
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

  EditImageScreenBloc({this.imageFile});

  @override
  EditImageScreenState get initialState => EditImageScreenInitialState();

  @override
  Stream<EditImageScreenState> mapEventToState(
      EditImageScreenEvent event) async* {
    print('event is $event');

    if (event is FiltersButtonHasBeenPressed) {
      List<Filter> filters = createFilterList();
      yield AddFiltersSuccessState(filters: filters);
    } else if (event is ParametersButtonHasBeenPressed) {
      yield AddParametersSuccessState();
    } else if (event is NoFilterHasBeenPressed) {
      print('im here bitttch');
      yield ImageFilterSuccessState(currentColor: endColors[0],filters: createFilterList() );
    } else if (event is ClassicHasBeenPressed) {
      yield ImageFilterSuccessState(currentColor: endColors[1],filters: createFilterList());
    } else if (event is RetroHasBeenPressed) {
      yield ImageFilterSuccessState(currentColor: endColors[2],filters: createFilterList());
    } else if (event is SphinexHasBeenPressed) {
      yield ImageFilterSuccessState(currentColor: endColors[3],filters: createFilterList());
    } else if (event is RubyHasBeenPressed) {
      yield ImageFilterSuccessState(currentColor: endColors[4], filters: createFilterList());
    } else if (event is ClipperdHasBeenPressed) {
      yield ImageFilterSuccessState(currentColor: endColors[5], filters: createFilterList());
    } else if (event is SaphirHasBeenPressed) {
      yield ImageFilterSuccessState(currentColor: endColors[6], filters: createFilterList());
    } else if (event is CleanHasBeenPressed) {
      yield ImageFilterSuccessState(currentColor: endColors[7], filters: createFilterList());
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

    List<EditImageScreenEvent> events = [
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
}
