import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserRegEvent extends Equatable {}

class SignUpButtonPressedEvent extends UserRegEvent {

  final String email;
  final String password;

  SignUpButtonPressedEvent({@required this.email, @required this.password});


  @override
  // TODO: implement props
  List<Object> get props => null;

}