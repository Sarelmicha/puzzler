import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/notification_bloc/notification_bloc.dart';
import 'package:puzzlechat/bloc/notification_bloc/notification_state.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/ui/widgets/card_widget.dart';

class CardList extends StatelessWidget {

  final List<GameData> cardsData;
  final NotificationBloc notificationBloc;
  final FirebaseUser currentUser;

  CardList({this.cardsData, this.notificationBloc,this.currentUser});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<NotificationBloc, NotificationState>(

      //Fetch new data while we are in the notification screen.
      builder: (context, state) {
        print('state is $state');
        //Fetching new data when entering the notificaion screen.
        return ListView.builder(
          itemBuilder: (context, index) {
            print('im sender yooooo ${cardsData[index].sender}');
            return CardWidget(
              cardData: cardsData[index],
              notificationBloc: notificationBloc,
              currentUser: currentUser,
            );
          },
          itemCount: cardsData.length,
        );
      },
    );
  }
}
