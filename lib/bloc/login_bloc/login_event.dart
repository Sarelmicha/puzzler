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

class VerifyPhoneNumberCompleteEvent extends LoginEvent {

  final FirebaseUser user;
  final String verificationId;

  VerifyPhoneNumberCompleteEvent({@required this.user,@required this.verificationId});

  @override
  List<Object> get props => null;

}