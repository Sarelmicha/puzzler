import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_event.dart';
import 'package:puzzlechat/ui/widgets/icon_text_field.dart';
import 'package:puzzlechat/ui/widgets/picker_widget.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';

class ParametersMenuWidget extends StatelessWidget {

  final int totalTime;
  final int numOfPieces;
  final EditImageScreenBloc bloc;

  ParametersMenuWidget({@required this.totalTime,@required this.numOfPieces, @required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  PickerWidget(
                    text: 'Time',
                    value: totalTime.toString(),
                    onLeftTap: (){
                      bloc.add(TimerLeftButtonHasBeenPressed());
                    },
                    onRightTap: (){
                      bloc.add(TimerRightButtonHasBeenPressed());
                    },
                  ),
                  SizedBox(height: 10.0),
                  PickerWidget(
                    text: 'Pieces',
                    value: numOfPieces.toString(),
                    onLeftTap: (){
                      bloc.add(PiecesLeftButtonHasBeenPressed());
                    },
                    onRightTap: (){
                      bloc.add(PiecesRightButtonHasBeenPressed());
                    },
                  ),
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
              RoundedButton(
                text: 'SEND',
                width: 100,
                height: 50,
              ),
            ],
          ),
          IconTextField(
            hint: 'Enter your message',
            obscureText: false,
            textInputType: TextInputType.text,
            padding: EdgeInsets.all(5.0),
          ),
        ],
      ),
    );
  }
}
