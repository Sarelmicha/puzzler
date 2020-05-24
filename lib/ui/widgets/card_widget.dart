import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/notification_bloc/notifcation_event.dart';
import 'package:puzzlechat/bloc/notification_bloc/notification_bloc.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/util/contstants.dart';

class CardWidget extends StatelessWidget {

  final GameData cardData;
  final NotificationBloc notificationBloc;
  final FirebaseUser currentUser;

  CardWidget({this.cardData,this.notificationBloc, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        notificationBloc.add(
            GameHasBeenClicked(
               gameData: cardData,
              currentUser : currentUser,
            )
        );
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.pink,
                  blurRadius:
                  20.0, // has the effect of softening the shadow
                  spreadRadius:
                  1.0, // has the effect of extending the shadow
                  offset: Offset(
                    5.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.purpleAccent, Colors.purple])
          ),
          width: double.infinity,
          height: 100.0,
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    cardData.sender,
                    style: kLabelTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 25.0
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'Total Time : ${cardData.totalTime}',
                      style: kLabelTextStyle.copyWith(
                        color: Colors.white,
                      ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Puzzle Pieces : ${int.parse(cardData.numOfRows) * int.parse(cardData.numOfRows)}',
                    style: kLabelTextStyle.copyWith(
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
