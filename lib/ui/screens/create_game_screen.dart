import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:puzzlechat/util/contstants.dart';
import 'package:animated_widgets/animated_widgets.dart';

class CreateGameScreen extends StatefulWidget {
  @override
  _CreateGameScreenState createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Puzzler',
          style: kLogoTextStyle.copyWith(
            fontSize: 30.0
          )
        ),
        backgroundColor: Colors.purpleAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.purpleAccent, Colors.pinkAccent]),
        ),



        child: Center(
          child: DottedBorder(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            strokeWidth: 1,
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Smile!',
                      style: kLogoTextStyle.copyWith(
                        fontSize: 40.0,
                      )
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ShakeAnimatedWidget(
                      duration: Duration(milliseconds: 1500),
                      shakeAngle: Rotation.deg(z: 10),
                      curve: Curves.linear,
                      child: GestureDetector(
                        onTap: (){

                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 80.0,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
