import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/notification_bloc/notification_bloc.dart';
import 'package:puzzlechat/bloc/notification_bloc/notification_state.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/ui/widgets/card_widget.dart';

class CardList extends StatelessWidget {

  final FirebaseUser currentUser;
  final List<GameData> cardsData;

  CardList({this.currentUser,this.cardsData});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<NotificationBloc, NotificationState>(

      //Fetch new data while we are in the notification screen.
      builder: (context, state) {
        if (state is NotificationScreenReady) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return CardWidget(
                cardData: state.cardsData[index],
              );
            },
            itemCount: state.cardsData.length,
          );
        }

        //Fetching new data when entering the notificaion screen.
        return ListView.builder(
          itemBuilder: (context, index) {
            return CardWidget(
              cardData: cardsData[index],
            );
          },
          itemCount: cardsData.length,
        );
      },
    );
  }
}
