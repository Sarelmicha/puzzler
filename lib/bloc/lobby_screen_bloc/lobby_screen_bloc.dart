import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_event.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_state.dart';
import 'package:puzzlechat/repository/user_repository.dart';
import 'package:puzzlechat/data/contact.dart' as myContact;

class LobbyScreenBloc extends Bloc<LobbyScreenEvent, LobbyScreenState> {
  UserRepository userRepository;
  FirebaseUser user;

  LobbyScreenBloc(FirebaseUser user) {
    this.userRepository = UserRepository();
    this.user = user;
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

        print('before fecthing all contact from phone');
        Iterable<Contact> contacts = await ContactsService.getContacts();
        print('after fecthing all contact from phone');

        print('here 2');

        List<Contact> phoneContactsList = contacts.toList();

        //--------------- for print for tests--------------
        for (int i = 0; i < phoneContactsList.length; i++) {
          print(phoneContactsList[i].displayName);
        }
        //---------------------------------------

        List<myContact.Contact> appContacts = await
            getAllContactWithApp(phoneContactsList);

        print(appContacts);

        //List<Contact> contacts = await getContacts();
        yield LobbyScreenReady(contacts: appContacts);
      } catch (e) {
        if (Platform.isAndroid) {
          yield LobbyScreenFailure(message: e.message);
        } else {
          //TODO- in the future need to take care of IOS
        }
      }
    }
  }

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

  Future<List<myContact.Contact>> getAllContactWithApp(List<Contact> phoneContacts) async{

    List<myContact.Contact> appContacts = [];

    print('here in getAllContactWithApp');

      QuerySnapshot users = await userRepository.getAllUsers();

    print('here in api call');
    print('length in phoneContact ${phoneContacts.length}');
    print('length in users is ${users.documents.length}' );

      for(var user in users.documents){
        print('here in for1');
        for(var contact in phoneContacts){
          print('here in for2');
          print('length is ${contact.phones.length}');
          if(contact.phones.length > 0) {
            String phoneNumber = cleanPhoneNumberFromTokens(contact.phones.first.value.toString());
            print('phoneNumber is $phoneNumber');

            if (phoneNumber == user.data['phoneNumber']) {
              print('im here!!');
              appContacts.add(myContact.Contact(
                  name: contact.displayName,
                  phoneNumber: phoneNumber,
              ));
            }
          }
        }
      }


      for(int i = 0; i < appContacts.length; i++){
        print('contact is ${appContacts[i]}');
      }

    return appContacts;
  }

  String cleanPhoneNumberFromTokens(String phoneNumber) {

    if(phoneNumber.substring(0,1) == '+'){
      return phoneNumber.replaceAll('-', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', '');
    }

    return phoneNumber;
  }
}
