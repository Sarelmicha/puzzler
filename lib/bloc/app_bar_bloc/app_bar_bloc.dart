
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_event.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_state.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/repository/user_repository.dart';
import 'package:puzzlechat/util/converter.dart';

class AppBarBloc extends Bloc<AppBarEvent,AppBarState> {

  UserRepository userRepository;
  FirebaseUser currentUser;

  AppBarBloc(FirebaseUser currentUser) {
    this.userRepository = UserRepository();
    this.currentUser = currentUser;
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

       print('Notification button has been pressed!');
       DocumentSnapshot snapshot = await userRepository.getSpecificUser(currentUser.phoneNumber);
       print('snapshot data is ${snapshot.data['games'].runtimeType}');
       List<GameData> cardsData = getGamesData(snapshot.data['games']);
       print('here 2');
       yield ShowNotificationSuccess(cardsData : cardsData);
     }
  }

  List<GameData> getGamesData(Map <String, dynamic> fromSaveableMap) {

    print('inside getGameData');
    List<GameData> allGames = List();

    fromSaveableMap.forEach((key, value) {
      print('value is ${value.runtimeType}');
      Converter.fromSaveableList(value).forEach((element) {
        print('hereeeee');
        allGames.add(element);
      });
    });


    print('finish getGamesData and allGames length is ${allGames.length}');

    return allGames;

  }
}





