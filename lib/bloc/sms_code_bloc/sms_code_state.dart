import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class SMSCodeState extends Equatable {}

class SMSCodeInitial extends SMSCodeState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SMSCodeLoadingState extends SMSCodeState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class SMSCodeSuccessful extends SMSCodeState {

  final FirebaseUser user;

  SMSCodeSuccessful({@required this.user});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SMSCodeFailure extends SMSCodeState {

  final String message;

  SMSCodeFailure({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => null;
}