import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_event.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_state.dart';
import 'package:puzzlechat/repository/user_repository.dart';
import 'package:puzzlechat/data/contact.dart' as myContact;

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
        await _askPermissions();

        print('here 1');
        Iterable<Contact> contacts = await ContactsService.getContacts();

        print('here 2');

        List<Contact> phoneContactList = contacts.toList();

        for(int i = 0; i < phoneContactList.length; i++){
          print(phoneContactList[i].displayName);
        }

        List<myContact.Contact> allContactWithApp = getAllContactWithApp(phoneContactList);

        print(allContactWithApp);

        //List<Contact> contacts = await getContacts();
        yield LobbyScreenReady(contacts: allContactWithApp);
      } catch (e) {
        if (Platform.isAndroid) {
          yield LobbyScreenFailure(message: e.message);
        } else {
          //TODO- in the future need to take care of IOS
        }
      }
    }
  }

//  Future<List<Contact>> getContacts() async {
//    List<Contact> contacts = [];
//
//    int sizeOfContacts = 100; // dummy value for now.
//    //TODO - access to Database for fetching contact data.
//
//    for (int i = 0; i < sizeOfContacts; i++) {
//      contacts.add(
//          Contact(name: 'User ${i + 1}', avatarUrl: 'images/profile_img.png'));
//    }
//
//    return contacts;
//  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.request();
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.location,
        Permission.storage,
      ].request();
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  List<myContact.Contact> getAllContactWithApp(List<Contact> contacts) {

    List<myContact.Contact> allContactsWithApp = [];

    for(int i = 0; i < contacts.length; i++){
      allContactsWithApp.add(myContact.Contact(name: contacts[i].displayName));
    }

    return allContactsWithApp;

  }
}
