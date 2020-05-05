import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/contact_bloc.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/ui/widgets/contact_list.dart';
import 'package:puzzlechat/util/contstants.dart';

class LobbyScreen extends StatefulWidget {

  FirebaseUser currentUser;

  LobbyScreen({@required this.currentUser});

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {

//  GameData screenArguments;
//  ContactBloc contactBloc;

  @override
  Widget build(BuildContext context) {

//    screenArguments = ModalRoute.of(context).settings.arguments;
//    contactBloc = screenArguments.contactBloc;

    return Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.purpleAccent, Colors.pinkAccent])),
            child: Center(
//              child: ContactList(contactBloc: contactBloc),
            ),
          ),
        ));
  }
}


