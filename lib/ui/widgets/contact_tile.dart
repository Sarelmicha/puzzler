import 'package:flutter/material.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/ui/screens/create_game_screen.dart';
import 'package:puzzlechat/ui/screens/waiting_screen.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';

class ContactTile extends StatelessWidget {

  final String name;
  final String avatarUrl;

  ContactTile({@required this.name, @required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return
        ListTile(
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          trailing:  RoundedButton(
            text: 'Invite',
            width: 30,
            height: 20,
            onPressed: (){
              Navigator.pushNamed(
                  context,
                  CreateGameScreen.id
              );
            },
          ),
    );
  }
}



