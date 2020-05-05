import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzlechat/data/contact.dart';

abstract class LobbyScreenState extends Equatable {}

class LobbyScreenInitial extends LobbyScreenState {
  @override
  List<Object> get props => null;
}

class LobbyScreenLoading extends LobbyScreenState {
  @override
  List<Object> get props => null;
}

class LobbyScreenReady extends LobbyScreenState {

  List<Contact> contacts = <Contact>[];

  LobbyScreenReady({@required this.contacts});


  @override
  List<Object> get props => null;
}

class LobbyScreenFailure extends LobbyScreenState {

  String message;

  LobbyScreenFailure({@required this.message});

  @override
  List<Object> get props => null;
}
