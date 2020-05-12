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
  // TODO: implement initialState
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      try {
        yield LoginLoadingState();

        FirebaseUser user;
        String verificationId;

        await userRepository.loginUser(event.phoneNumber, user, verificationId);
        if(user != null){
          yield LoginSuccessState(user: user);
        }  else {
          yield CodeState(verificationId: verificationId);
        }
      } catch (e) {
        if(Platform.isAndroid) {
          yield LoginFailureState(message: e.message);
        } else {
          //TODO- in the future need to take care of IOS
        }
      }
    }
  }
}
