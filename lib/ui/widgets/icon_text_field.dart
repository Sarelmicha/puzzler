import 'package:flutter/material.dart';
import 'package:puzzlechat/util/contstants.dart';

class IconTextField extends StatelessWidget {

  final IconData iconData;
  final String hint;
  final bool obscureText;
  final TextInputType textInputType;
  final EdgeInsets padding;
  final TextEditingController controller;
  final String errorText;

  IconTextField({this.iconData,this.hint,this.obscureText,this.textInputType,this.padding,this.controller,this.errorText});


  @override
  Widget build(BuildContext context) {

    print('error text $errorText');

    return Padding(
      padding: padding,
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: textInputType,
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
          errorText: errorText
        ),
      ),
    );
  }
}