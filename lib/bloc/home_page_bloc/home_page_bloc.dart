

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/home_page_bloc/home_page_event.dart';
import 'package:puzzlechat/bloc/home_page_bloc/home_page_state.dart';
import 'package:puzzlechat/repository/user_repository.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {

  UserRepository userRepository;

  HomePageBloc() {
    this.userRepository = UserRepository();
  }

  @override
  // TODO: implement initialState
  HomePageState get initialState => LogOutInitial();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if(event is LogOutButtonPressedEvent){
        await userRepository.signOut();
        yield LogOutSuccess();
    }
  }

}