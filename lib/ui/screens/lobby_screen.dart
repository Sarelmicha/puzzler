import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_event.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_state.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_bloc.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_event.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_state.dart';
import 'package:puzzlechat/ui/widgets/contact_list.dart';
import 'package:puzzlechat/util/navigator_helper.dart';
import 'package:puzzlechat/util/contstants.dart';

class LobbyScreenParent extends StatelessWidget {

  final FirebaseUser currentUser;

  LobbyScreenParent({@required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBarBloc>(
      create: (context) => AppBarBloc(),
      child: BlocProvider<LobbyScreenBloc>(
          create: (context) => LobbyScreenBloc()..add(EnterLobbyEvent()),
          child: LobbyScreen()),
    );
  }
}

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {

  LobbyScreenBloc lobbyScreenBloc;
  AppBarBloc appBarBloc;


  @override
  Widget build(BuildContext context) {

    lobbyScreenBloc = BlocProvider.of<LobbyScreenBloc>(context);
    appBarBloc = BlocProvider.of<AppBarBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title:  Text(
            'Puzzler',
            style: kLogoTextStyle.copyWith(
              fontSize: 30.0
            ),
          ),
          backgroundColor: Colors.purpleAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                appBarBloc.add(LogoutButtonHasBeenPressed());
              },
            )
          ],
        ),
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.purpleAccent, Colors.pinkAccent])),
            child: BlocListener<AppBarBloc,AppBarState>(
              listener: (context, appBarState) {
                if(appBarState is LogOutSuccess){
                  NavigatorHelper.navigateToLoginScreen(context);
                } else if(appBarState is ShowSettingsSuccess){
                  //TODO - Navigate to Settings page.
                } else if(appBarState is ShowNotificationSuccess){
                  //TODO - Navigate to Notification page.
                }
              },
              child: BlocListener<LobbyScreenBloc, LobbyScreenState>(
                listener: (context, lobbyScreenState) {
                  if (lobbyScreenState is LobbyScreenLoading) {
                    NavigatorHelper.navigateToSplashScreen(context);
                  } else if (lobbyScreenState is LobbyScreenReady) {
                    NavigatorHelper.navigateBackToCurrentScreen(context);
                  }
                },
                child: Center(child: ContactList()),
              ),
            ),
          ),
        ));
  }


  @override
  void dispose() {
    super.dispose();
    lobbyScreenBloc.close();
    appBarBloc.close();
  }
}
