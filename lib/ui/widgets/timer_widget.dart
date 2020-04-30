import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/timer_bloc.dart';
import 'package:puzzlechat/ui/screens/waiting_screen.dart';

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

        return Container(
          width: 80,
          height: 80,
          child: CircularCountdown(
            countdownTotalColor: Color(0xffffddc0),
            countdownCurrentColor: Color(0xffffddc0),
            countdownRemainingColor: Colors.white,
            diameter:  250,
            countdownTotal:  startTime,
            countdownRemaining: snapshot.data,
          ),
        );


//        return Container(
//          child:  CircleAvatar(
//            child: Text(
//              snapshot.data.toString(),
//              style: TextStyle(
//                color: Colors.white,
//                fontWeight: FontWeight.bold,
//                fontSize: 30.0,
//              ),
//            ),
//          ),
//          width: 80.0,
//          height: 80.0,
//          padding: EdgeInsets.all(2.0), // border width
//          decoration: BoxDecoration(
//            color: Colors.white, // border color
//            shape: BoxShape.circle,
//          ),
//        );
      }
    );
  }
}