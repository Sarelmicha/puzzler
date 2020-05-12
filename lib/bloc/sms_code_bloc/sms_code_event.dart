import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SMSCodeEvent extends Equatable {}

class CodeButtonPressedEvent extends SMSCodeEvent {

  final String verificationId;
  final String smsCode;

  CodeButtonPressedEvent({@required this.verificationId, @required this.smsCode});


  @override
  // TODO: implement props
  List<Object> get props => null;

}