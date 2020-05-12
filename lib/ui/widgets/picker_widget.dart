import 'package:flutter/material.dart';
import 'package:puzzlechat/util/contstants.dart';

class PickerWidget extends StatelessWidget {

  final String text;
  final String value;
  final Function onRightTap;
  final Function onLeftTap;

  PickerWidget({@required this.text, @required this.value, @required this.onLeftTap, @required this.onRightTap});

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
        GestureDetector(
          onTap: onLeftTap,
          child: Icon(
            Icons.arrow_left,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        Text(
          value,
          style: kLogoTextStyle.copyWith(
            fontSize: 30
          ),
        ),
        GestureDetector(
          onTap: onRightTap,
          child: Icon(
            Icons.arrow_right,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ],
    );
  }
}