import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_bloc.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_event.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_state.dart';
import 'package:puzzlechat/ui/screens/splash_screen.dart';
import 'package:puzzlechat/ui/widgets/contact_list.dart';



class LobbyScreenParent extends StatelessWidget {

  final FirebaseUser currentUser;

  LobbyScreenParent({@required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LobbyScreenBloc()..add(EnterLobbyEvent()),
      child: LobbyScreen()
    );
  }
}

class LobbyScreen extends StatefulWidget  {

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}


class _LobbyScreenState extends State<LobbyScreen> {

  LobbyScreenBloc lobbyScreenBloc;

  @override
  Widget build(BuildContext context) {

    lobbyScreenBloc = BlocProvider.of<LobbyScreenBloc>(context);

    return Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.purpleAccent, Colors.pinkAccent]
                )
            ),
            child: BlocListener<LobbyScreenBloc, LobbyScreenState>(
              listener: (context, state) {

                print('state isss $state');

                if (state is LobbyScreenLoading) {
                  navigateToSplashScreen(context);
                } else if(state is LobbyScreenReady){
                  navigateBackToLobbyScreen(context);
                }
              },
              child: Center(child: ContactList()),
            ),
          ),
        )
    );
  }

  void navigateToSplashScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SplashScreen();
    }));
  }

  void navigateBackToLobbyScreen(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    lobbyScreenBloc.close();
  }
}


