import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  GradientButton({this.text,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50.0,
        child: FlatButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.pink,Colors.purple],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0 ),
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
