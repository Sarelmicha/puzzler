
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/reg_bloc/user_reg_event.dart';
import 'package:puzzlechat/bloc/reg_bloc/user_reg_state.dart';
import 'package:puzzlechat/repository/user_repository.dart';

class UserRegBloc extends Bloc<UserRegEvent,UserRegState> {

  UserRepository userRepository;


  UserRegBloc() {
    this.userRepository = UserRepository();
  }

  @override
  UserRegState get initialState => UserRegInitial();


  @override
  Stream<UserRegState> mapEventToState(UserRegEvent event) async* {
    if (event is SignUpButtonPressedEvent) {
      try {
        yield UserLoadingState();
        var user = await userRepository.createUser(event.email, event.password);
        yield UserRegSuccessful(user: user);
      } catch (e) {
        if(Platform.isAndroid) {
          yield UserRegFailure(message: e.message);
        } else {
          //TODO- need to handle IOS
        }
      }
    }
  }



}
