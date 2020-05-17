import 'package:flutter/material.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/util/contstants.dart';

class CardWidget extends StatelessWidget {

  final GameData cardData;

  CardWidget({this.cardData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //TODO - Start the game.
      },
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
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  cardData.sender,
                  style: kLabelTextStyle.copyWith(
                    fontSize: 30.0
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                    'Total Time : ${cardData.totalTime}',
                    style: kLabelTextStyle,
                ),
                Text(
                  'Puzzle Pieces : ${int.parse(cardData.numOfRows) * int.parse(cardData.numOfRows)}',
                  style: kLabelTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
