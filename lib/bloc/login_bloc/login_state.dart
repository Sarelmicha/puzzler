import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoginLoadingState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CodeState extends LoginState {

  final String verificationId;

  CodeState({this.verificationId});

  @override
  // TODO: implement props
  List<Object> get props => null;

}


class LoginSuccessState extends LoginState {

  final FirebaseUser user;

  LoginSuccessState({@required this.user});

  @override
  List<Object> get props => null;
}

class LoginFailureState extends LoginState {

  final String message;

  LoginFailureState({@required this.message});

  @override
  List<Object> get props => null;
}