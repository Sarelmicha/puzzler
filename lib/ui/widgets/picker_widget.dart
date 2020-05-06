import 'package:flutter/material.dart';
import 'package:puzzlechat/util/contstants.dart';

class PickerWidget extends StatelessWidget {

  final String text;
  final String value;

  PickerWidget({@required this.text, @required this.value});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: kLogoTextStyle.copyWith(
            fontSize: 30,
          ),
        ),
        SizedBox(width: 20.0),
        Icon(
          Icons.arrow_left,
          color: Colors.white,
          size: 30.0,
        ),
        Text(
          value,
          style: kLogoTextStyle.copyWith(
            fontSize: 30
          ),
        ),
        Icon(
          Icons.arrow_right,
          color: Colors.white,
          size: 30.0,
        ),
      ],
    );
  }
}