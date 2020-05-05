import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/ui/screens/game_screen.dart';
import 'package:puzzlechat/ui/widgets/custom_drop_down.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/contstants.dart';

class CreateGameScreen extends StatefulWidget {

  @override
  _CreateGameScreenState createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  int numOfRows = 3;
  int totalTime;
  String imageUrl;
  List<Image> pieces = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.purpleAccent, Colors.pinkAccent]
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
//                GridView.count(
//                  primary: false,
//                  padding: const EdgeInsets.all(0),
//                  crossAxisSpacing: 0,
//                  mainAxisSpacing: 0,
//                  crossAxisCount: numOfRows,
//                  children: pieces,
//                ),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(Icons.camera_alt),
                    ),
                    CustomDropDown(items: [9, 16, 25, 36], onChanged: () {}),
                    CustomDropDown(items: [30, 60, 90, 120], onChanged: () {}),
                  ],
                ),
              ],
            ),
            RoundedButton(
                text: "Send",
                width: 200,
                height: 200,
                onPressed: () {
//                  Navigator.pushNamed(context, GameScreen.id);
                }),
          ],
        ),
      ),
    ));
  }
}
