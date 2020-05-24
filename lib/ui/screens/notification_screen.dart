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
import 'package:puzzlechat/bloc/notification_bloc/notification_bloc.dart';
import 'package:puzzlechat/bloc/notification_bloc/notification_state.dart';
import 'package:puzzlechat/data/contact.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/ui/widgets/card_list.dart';
import 'package:puzzlechat/ui/widgets/contact_list.dart';
import 'package:puzzlechat/util/navigator_helper.dart';
import 'package:puzzlechat/util/contstants.dart';

class NotificationScreenParent extends StatelessWidget {
  final List<GameData> cardsData;
  final FirebaseUser currentUser;
  final List<Contact> userContacts;

  NotificationScreenParent(
      {@required this.cardsData, @required this.currentUser, this.userContacts});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBarBloc>(
      create: (context) => AppBarBloc(currentUser),
      child: BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(),
          child: NotificationScreen(
              cardsData: cardsData, currentUser: currentUser)),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  final List<GameData> cardsData;
  final FirebaseUser currentUser;
  NotificationScreen({this.cardsData, this.currentUser});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationBloc notificationBloc;
  AppBarBloc appBarBloc;

  @override
  Widget build(BuildContext context) {
    print('current user from lobby Screen is ${widget.currentUser}');

    notificationBloc = BlocProvider.of<NotificationBloc>(context);
    appBarBloc = BlocProvider.of<AppBarBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Puzzler',
            style: kLogoTextStyle.copyWith(fontSize: 30.0),
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
            child: BlocListener<AppBarBloc, AppBarState>(
              listener: (context, appBarState) {
                if (appBarState is LogOutSuccess) {
                  NavigatorHelper.navigateToLoginScreen(context);
                } else if (appBarState is ShowSettingsSuccess) {
                  //TODO - Navigate to Settings page.
                } else if (appBarState is ShowNotificationSuccess) {
                  //TODO - Navigate to Notification page.
                }
                return Container();
              },
              child: BlocListener<NotificationBloc, NotificationState>(
                listener: (context, notificationState) {
                  if (notificationState is GameStartedState) {
                    NavigatorHelper.navigateToGameScreenScreen(
                        context,
                        notificationState.image,
                        int.parse(notificationState.totalTime),
                        int.parse(notificationState.numOfRows),
                        widget.currentUser
                    );
                  } else if(notificationState is NotificationWaitingState){
                    NavigatorHelper.navigateToSplashScreen(context);
                  }
                },
                child: Center(
                  child: CardList(
                    cardsData: widget.cardsData,
                    notificationBloc: notificationBloc,
                    currentUser: widget.currentUser,
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    notificationBloc.close();
    appBarBloc.close();
  }
}
