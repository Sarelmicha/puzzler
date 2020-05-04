import 'package:flutter/material.dart';
import 'package:puzzlechat/util/contstants.dart';

class IconTextField extends StatelessWidget {

  final IconData iconData;
  final String hint;
  final bool obscureText;
  final TextInputType textInputType;
  final EdgeInsets padding;

  IconTextField({this.iconData,this.hint,this.obscureText,this.textInputType,this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}