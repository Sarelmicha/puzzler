import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/contact_bloc.dart';
import 'package:puzzlechat/data/contact.dart';
import 'package:puzzlechat/ui/widgets/contact_tile.dart';


class ContactList extends StatelessWidget {

//  final ContactBloc contactBloc;

//  ContactList({this.contactBloc});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Contact>>(
      stream: null,
      builder: (context, snapshot) {


        if(!snapshot.hasData){
          return Center(
            child: Text('Waiting...'),
          );
        }
        return ListView.builder(
              itemBuilder: (context, index) {
                return ContactTile(
                  name: snapshot.data[index].name,
                  avatarUrl: snapshot.data[index].avatarUrl,
                );
              },
              itemCount: snapshot.data.length,
            );
      }
    );
  }
}
