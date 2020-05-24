import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/game_bloc/game_bloc.dart';
import 'package:puzzlechat/bloc/game_bloc/game_event.dart';

class TimerWidget extends StatelessWidget {

  final int totalTime;
  final GameBloc gameBloc;

  TimerWidget({this.totalTime,this.gameBloc});

  @override
  Widget build(BuildContext context) {
    return ArgonTimerButton(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.45,
      onTap: (startTimer, btnState) {
        if (btnState == ButtonState.Idle) {
          gameBloc.add(PlayButtonHasBeenPressedEvent());
          startTimer(totalTime);
        }
      },
      child: Text(
        "Play",
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      loader: (timeLeft) {

        if(timeLeft == 0){
          gameBloc.add(TimeHasPassedEvent());
        }

        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)),
          margin: EdgeInsets.all(5),
          alignment: Alignment.center,
          width: 40,
          height: 40,
          child: Text(
            "$timeLeft",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        );
      },
      borderRadius: 5.0,
      color: Color(0xFF7866FE),
    );
  }
}
