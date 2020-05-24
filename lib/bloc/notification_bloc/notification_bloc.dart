import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:puzzlechat/bloc/notification_bloc/notifcation_event.dart';
import 'package:puzzlechat/bloc/notification_bloc/notification_state.dart';
import 'package:puzzlechat/repository/game_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


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

      yield NotificationWaitingState();

      Uint8List image = await downloadImageFromStorage(event.gameData.imageUrl);

      //TODO - what to do if image is null

      print('is valid man??? ${JpegDecoder().isValidFile(image)}');
      //Start Game
      yield GameStartedState(image: image, totalTime: event.gameData.totalTime, numOfRows: event.gameData.numOfRows);
      //Delete that game from DB.

      //TODO- check what wrong with delete game method
      //gameRepository.deleteGame(event.currentUser.phoneNumber,event.gameData.sender,event.gameData.gameId);
    }

  }

  Future<Uint8List> downloadImageFromStorage(String imageUrl) async {


    final http.Response response = await http.get(imageUrl);
    //Cannot make get call
    if (response.statusCode == 200) {
      String data = response.body;
      return response.bodyBytes;
    } else {
      print('somthing went wrong with status code ${response.statusCode}');
    }
    return null;
  }
}
