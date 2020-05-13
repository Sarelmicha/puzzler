import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {}

class LoginButtonPressedEvent extends LoginEvent {

  final String phoneNumber;

  LoginButtonPressedEvent({@required this.phoneNumber});

  @override
  List<Object> get props => null;

}

class VerifyPhoneNumberSuccessEvent extends LoginEvent {

  final FirebaseUser user;
  final String verificationId;

  VerifyPhoneNumberSuccessEvent({@required this.user,@required this.verificationId});

  @override
  List<Object> get props => null;

}

class VerifyPhoneNumberFailureEvent extends LoginEvent {

  final String message;
  VerifyPhoneNumberFailureEvent({@required this.message});

  @override
  List<Object> get props => null;

}