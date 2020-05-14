import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/navigator_helper.dart';

class ContactTile extends StatelessWidget {

  final String name;
  final String receiverPhoneNumber;
  final FirebaseUser currentUser;

  ContactTile({@required this.name, this.receiverPhoneNumber,this.currentUser});

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
              NavigatorHelper.navigateToPickImageScreen(context,receiverPhoneNumber,currentUser);
            },
          ),
    );
  }
}



