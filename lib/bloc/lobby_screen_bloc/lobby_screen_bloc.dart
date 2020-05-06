import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_event.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_state.dart';
import 'package:puzzlechat/data/contact.dart';
import 'package:puzzlechat/repository/user_repository.dart';

class LobbyScreenBloc extends Bloc<LobbyScreenEvent, LobbyScreenState> {

  UserRepository userRepository;

  LobbyScreenBloc() {
    this.userRepository = UserRepository();
  }

  @override
  LobbyScreenState get initialState => LobbyScreenInitial();

  @override
  Stream<LobbyScreenState> mapEventToState(LobbyScreenEvent event) async* {

    print('event is $event');

    if (event is EnterLobbyEvent) {
      try {
        print('before initial lobbyScreenInitial');
        yield LobbyScreenLoading();
        //Here comes the logic of fetching data from Firebase
        List<Contact> contacts =  await getContacts();
        yield LobbyScreenReady(contacts:  contacts);
      } catch (e) {
        if (Platform.isAndroid) {
          yield LobbyScreenFailure(message: e.message);
        } else {
          //TODO- in the future need to take care of IOS
        }
      }
    }
  }

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];

    int sizeOfContacts = 100; // dummy value for now.
    //TODO - access to Database for fetching contact data.

    for (int i = 0; i < sizeOfContacts; i++) {
      contacts.add(
          Contact(name: 'User ${ i +  1}', avatarUrl: 'images/profile_img.png'));
    }

    return contacts;
  }
}
