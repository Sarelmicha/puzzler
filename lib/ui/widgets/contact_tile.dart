import 'package:flutter/material.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/ui/screens/pick_image_screen.dart';
import 'package:puzzlechat/ui/screens/splash_screen.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/navigator_helper.dart';

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
              NavigatorHelper.navigateToPickImageScreen(context);
            },
          ),
    );
  }
}



