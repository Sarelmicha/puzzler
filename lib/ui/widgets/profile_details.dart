import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child:  CircleAvatar(
            backgroundColor: Colors.white,
          ),
          width: 40.0,
          height: 40.0,
          padding: EdgeInsets.all(2.0), // border width
          decoration: BoxDecoration(
            color: Colors.blueAccent, // border color
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          'Sarel Micha',
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}