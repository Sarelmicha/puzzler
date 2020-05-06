
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_event.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_state.dart';
import 'package:puzzlechat/bloc/auth_bloc/auth_event.dart';
import 'package:puzzlechat/bloc/auth_bloc/auth_state.dart';
import 'package:puzzlechat/repository/user_repository.dart';

class AppBarBloc extends Bloc<AppBarEvent,AppBarState> {

  UserRepository userRepository;

  AppBarBloc() {
    this.userRepository = UserRepository();
  }

  @override
  AppBarState get initialState => AppBarInitial();

  @override
  Stream<AppBarState> mapEventToState(AppBarEvent event) async* {

     if(event is LogoutButtonHasBeenPressed){
      userRepository.signOut();
      yield LogOutSuccess();
    } else if(event is SettingsButtonHasBeenPressed){
       yield ShowSettingsSuccess();
     } else if(event is NotificationButtonHasBeenPressed){

       //TODO - get all notification from Firebase
       yield ShowNotificationSuccess();
     }
  }
}





