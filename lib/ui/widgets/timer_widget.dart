import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/timer_bloc.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

class TimerWidget extends StatelessWidget {

  final TimerBloc timerBloc;
  final int startTime;
  TimerWidget({this.timerBloc,this.startTime});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<int>(
      stream: timerBloc.stream,
      builder: (context, snapshot) {

        if(!snapshot.hasData){
          return Center(child: Text(
              'Loading...',
            style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
          ));
        }

        if(snapshot.data == 0){
          print('user lost');
        }

        return ArgonTimerButton(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.45,
          onTap: (startTimer, btnState) {
            if (btnState == ButtonState.Idle) {
              startTimer(startTime);
            }
          },
          child: Text(
            "START",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          loader: (timeLeft) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
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
          color: Colors.purple
        );

        return Container(
          child:  CircleAvatar(
            child: Text(
              snapshot.data.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ),
          width: 80.0,
          height: 80.0,
          padding: EdgeInsets.all(2.0), // border width
          decoration: BoxDecoration(
            color: Colors.white, // border color
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}