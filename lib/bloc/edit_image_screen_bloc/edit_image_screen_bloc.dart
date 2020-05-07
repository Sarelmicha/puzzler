import 'dart:io';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_state.dart';
import 'package:puzzlechat/data/filter.dart';


class EditImageScreenBloc
    extends Bloc<EditImageScreenEvent, EditImageScreenState> {

  File imageFile;

  EditImageScreenBloc({this.imageFile});

  @override
  EditImageScreenState get initialState => EditImageScreenInitialState();

  @override
  Stream<EditImageScreenState> mapEventToState(
      EditImageScreenEvent event) async* {

    print('event is $event');

    if (event is FiltersButtonHasBeenPressed) {
      //TODO - can add spinner while waiting to async function
      List<Filter> filters = createFilterList();
      yield AddFiltersSuccessState(filters: filters);
    }
  }

  List<Filter> createFilterList() {

    int numOfFilters = 6;
    List<Filter> filters = [];
    List<String> filterNames = ['No Filter', 'Classic','Retro','Sphinex','Ruby','Clipperd'];
    List<bool> isPickedList = [true, false, false, false, false, false];

    for(int i = 0; i < numOfFilters; i++){
      filters.add(Filter(
        imageFile: imageFile,
        isPicked: isPickedList[i],
        filterName: filterNames[i],
      ));
    }

    return filters;
  }
}
