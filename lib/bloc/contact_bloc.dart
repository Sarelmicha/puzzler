import 'dart:async';

import 'package:puzzlechat/bloc/bloc.dart';
import 'package:puzzlechat/data/cell.dart';
import 'package:puzzlechat/data/contact.dart';

class ContactBloc implements Bloc {
  var _contacts = <Contact>[];
  List<Contact> get contacts => _contacts;

  final _controller = StreamController<List<Contact>>();
  Stream<List<Contact>> get stream => _controller.stream;

  Future<void> getContacts() async{

    int sizeOfContacts = 1000000; // dummy value for now.
    //TODO - access to Database for fetching contact data.

    for (int i = 0; i < sizeOfContacts; i++) {
      _contacts
          .add(Contact(name: 'Yaniv Yona', avatarUrl: 'images/profile_img.png'));
    }
    _controller.sink.add(_contacts);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
