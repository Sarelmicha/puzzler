import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/auth_bloc/auth_bloc.dart';
import 'package:puzzlechat/bloc/auth_bloc/auth_event.dart';
import 'package:puzzlechat/bloc/auth_bloc/auth_state.dart';
import 'package:puzzlechat/ui/screens/lobby_screen.dart';
import 'package:puzzlechat/ui/screens/login_screen.dart';
import 'package:puzzlechat/ui/screens/splash_screen.dart';

void main() => runApp(PuzzleChat());

class PuzzleChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Test Commit

    print('app started.');

    return MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc()..add(AppStartedEvent()),
        child: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        if(state is AuthInitialState){
          return SplashScreen();
        } else if (state is AuthenticatedState){
            return LobbyScreenParent();
        } else if(state is UnAuthenticatedState){
           return LoginScreenParent();
        }
        return SplashScreen();
      }
    );
  }

}


