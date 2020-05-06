import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_event.dart';
import 'package:puzzlechat/ui/widgets/icon_text_field.dart';
import 'package:puzzlechat/ui/widgets/picker_widget.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/contstants.dart';

class EditImageScreenParent extends StatelessWidget {
  final File imageFile;
  EditImageScreenParent({this.imageFile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBarBloc>(
      create: (context) => AppBarBloc(),
      child: EditImageScreen(fileImage: imageFile),
    );
  }
}

class EditImageScreen extends StatefulWidget {
  final File fileImage;
  EditImageScreen({this.fileImage});

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  AppBarBloc appBarBloc;

  @override
  Widget build(BuildContext context) {
    appBarBloc = BlocProvider.of<AppBarBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Puzzler',
            style: kLogoTextStyle.copyWith(fontSize: 30.0),
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
                appBarBloc.add(LogoutButtonHasBeenPressed());
              },
            )
          ],
        ),
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.purpleAccent, Colors.pinkAccent])),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 350,
                  padding: EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.file(
                      widget.fileImage,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.rotate_right,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    color: Colors.white
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        PickerWidget(
                          text: 'Time',
                          value: '30',
                        ),
                        SizedBox(height: 10.0),
                        PickerWidget(
                          text: 'Piceses',
                          value: '9',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RoundedButton(
                        text: 'SEND',
                        width: 100,
                        height: 50,
                    ),
                  ],
                ),
                IconTextField(
                  hint: 'Enter your message',
                  obscureText: false,
                  textInputType: TextInputType.text,
                  padding: EdgeInsets.all(5.0),
                ),
              ],
            ),
          ),
        ));
  }
}
