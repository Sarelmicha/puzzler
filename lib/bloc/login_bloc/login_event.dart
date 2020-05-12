import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {}

class LoginButtonPressedEvent extends LoginEvent {

  final String phoneNumber;

  LoginButtonPressedEvent({@required this.phoneNumber});

  @override
  List<Object> get props => null;

}