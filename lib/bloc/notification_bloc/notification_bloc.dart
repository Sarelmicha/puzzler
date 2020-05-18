import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_event.dart';
import 'package:puzzlechat/bloc/login_bloc/login_state.dart';
import 'package:puzzlechat/bloc/notification_bloc/notifcation_event.dart';
import 'package:puzzlechat/bloc/notification_bloc/notification_state.dart';
import 'package:puzzlechat/repository/game_repository.dart';



class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  GameRepository gameRepository;

  NotificationBloc(){
    this.gameRepository = GameRepository();
  }


  @override
  NotificationState get initialState => NotificationInitialState();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {

    if(event is GameHasBeenClicked){

      //Start Game
      yield GameStartedState();
      //Delete that game from DB.
      gameRepository.deleteGame(event.receiverPhoneNumber,event.senderPhoneNumber,event.gameId);
    }

  }
}
