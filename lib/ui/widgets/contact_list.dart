import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_bloc.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_state.dart';
import 'package:puzzlechat/ui/widgets/contact_tile.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LobbyScreenBloc, LobbyScreenState>(
      builder: (context, state) {
        print('here from contact list');
        if (state is LobbyScreenReady) {
          print('here in if inside contact list');
          return ListView.builder(
            itemBuilder: (context, index) {
              return ContactTile(
                name: state.contacts[index].name,
                avatarUrl: state.contacts[index].avatarUrl,
              );
            },
            itemCount: state.contacts.length,
          );
        }
        return Container();
      },
    );
  }
}
