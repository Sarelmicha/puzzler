import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {}

class LoginButtonPressedEvent extends LoginEvent {

  final String email;
  final String password;

  LoginButtonPressedEvent({@required this.email, @required this.password});

  @override
  List<Object> get props => null;

}