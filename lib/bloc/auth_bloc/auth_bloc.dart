
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/auth_bloc/auth_event.dart';
import 'package:puzzlechat/bloc/auth_bloc/auth_state.dart';
import 'package:puzzlechat/repository/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState> {

  UserRepository userRepository;

  AuthBloc() {
    this.userRepository = UserRepository();
  }

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {

    if (event is AppStartedEvent) {
      try {
        var isSignedIn = await userRepository.isSignedIn();
        if (isSignedIn) {
          //User already authenticated.
          var user = await userRepository.getCurrentUser();
          yield AuthenticatedState(user: user);
        } else {
          yield UnAuthenticatedState();
        }
      } catch (e) {
        yield UnAuthenticatedState();
      }
    }
  }
}





