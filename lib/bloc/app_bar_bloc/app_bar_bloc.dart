
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_event.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_state.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/repository/user_repository.dart';

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

       DocumentSnapshot snapshot = await userRepository.getSpecificUser(currentUser.phoneNumber);
       List<GameData> cardsData = getGamesData(snapshot.data);
       //TODO - get all notification from Firebase
       yield ShowNotificationSuccess(cardsData);
     }
  }

  List<GameData> getGamesData(Map<String, Object> data) {



  }
}





