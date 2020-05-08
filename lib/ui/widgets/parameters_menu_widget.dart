import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_state.dart';
import 'package:puzzlechat/ui/widgets/icon_text_field.dart';
import 'package:puzzlechat/ui/widgets/picker_widget.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';

class ParametersMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Column(
                children: <Widget>[
                  PickerWidget(
                    text: 'Time',
                    value: '30',
                  ),
                  SizedBox(height: 10.0),
                  PickerWidget(
                    text: 'Piceses',
                    value: '9',
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
