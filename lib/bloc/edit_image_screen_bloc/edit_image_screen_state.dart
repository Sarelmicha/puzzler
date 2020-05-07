import 'package:equatable/equatable.dart';
import 'package:puzzlechat/data/filter.dart';



abstract class EditImageScreenState extends Equatable {}

class EditImageScreenInitialState extends EditImageScreenState {
  @override
  List<Object> get props => null;
}

class RotationSuccessState extends EditImageScreenState {
  @override
  List<Object> get props => throw UnimplementedError();

}

class AddStickerSuccessState extends EditImageScreenState {
  @override
  List<Object> get props => throw UnimplementedError();
}



class AddParametersSuccessState extends EditImageScreenState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AddFiltersSuccessState extends EditImageScreenState {

  final List<Filter> filters;
  AddFiltersSuccessState({this.filters});

  @override
  List<Object> get props => null;

}

class SendImageSuccessState extends EditImageScreenState {

  @override
  List<Object> get props => null;

}

class SendImageFailureState extends EditImageScreenState {

  @override
  List<Object> get props => null;

}
