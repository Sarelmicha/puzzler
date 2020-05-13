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
      try {
        yield LoginLoadingState();

        FirebaseUser user;
        String verificationId;

        userRepository.loginUser(event.phoneNumber, user, verificationId, this);
      } catch (e) {
        if (Platform.isAndroid) {
          yield LoginFailureState(message: e.message);
        } else {
          //TODO- in the future need to take care of IOS
        }
      }
    } else if (event is VerifyPhoneNumberCompleteEvent) {
      print('user after loginUser func is ${event.user}');
      if (event.user != null) {
        yield LoginSuccessState(user: event.user);
      } else {
        yield CodeState(verificationId: event.verificationId);
      }
    }
  }
}
