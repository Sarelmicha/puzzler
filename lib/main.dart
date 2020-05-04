import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/bloc_provider.dart';
import 'package:puzzlechat/bloc/cell_bloc.dart';
import 'package:puzzlechat/ui/screens/create_game_screen.dart';
import 'package:puzzlechat/ui/screens/game_screen.dart';
import 'package:puzzlechat/ui/screens/lobby_screen.dart';
import 'package:puzzlechat/ui/screens/login_screen.dart';
import 'package:puzzlechat/ui/screens/signup_screen.dart';
import 'package:puzzlechat/ui/screens/waiting_screen.dart';

void main() => runApp(PuzzleChat());

class PuzzleChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CellBloc>(
      bloc: CellBloc(numOfRows: 4),
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          CreateGameScreen.id : (context) => CreateGameScreen(),
          LobbyScreen.id : (context) => LobbyScreen(),
          SignupScreen.id : (context) => SignupScreen(),
          LoginScreen.id : (context) => LoginScreen(),
          WaitingScreen.id: (context) => WaitingScreen(),
          GameScreen.id: (context) => GameScreen()
        },
      ),
    );
  }
}


