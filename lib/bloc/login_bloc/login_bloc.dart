import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_event.dart';
import 'package:puzzlechat/bloc/login_bloc/login_state.dart';
import 'package:puzzlechat/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc() {
    this.userRepository = UserRepository();
  }

  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      yield LoginLoadingState();

      FirebaseUser user;
      String verificationId;

      userRepository.loginUser(event.phoneNumber, user, verificationId, this);
    } else if (event is VerifyPhoneNumberSuccessEvent) {
      print('user after loginUser func is ${event.user}');
      if (event.user != null) {
        yield LoginSuccessState(user: event.user);
      } else {
        yield CodeState(verificationId: event.verificationId);
      }
    } else if (event is VerifyPhoneNumberFailureEvent) {
      yield LoginFailureState(message: event.message);
    }
  }
}
