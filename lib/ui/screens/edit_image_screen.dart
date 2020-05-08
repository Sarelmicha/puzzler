import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_state.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_bloc.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_event.dart';
import 'package:puzzlechat/ui/widgets/edit_image_widget.dart';
import 'package:puzzlechat/ui/widgets/parameters_menu_widget.dart';
import 'package:puzzlechat/util/contstants.dart';
import 'package:puzzlechat/util/navigator_helper.dart';
import 'package:puzzlechat/ui/widgets/filters_list.dart';

class EditImageScreenParent extends StatelessWidget {
  final File imageFile;
  final PickImageScreenBloc pickImageScreenBloc;

  EditImageScreenParent({this.imageFile, this.pickImageScreenBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditImageScreenBloc>(
      create: (context) => EditImageScreenBloc(
        imageFile: imageFile,
      )..add(ParametersButtonHasBeenPressed()),
      child: BlocProvider<AppBarBloc>(
        create: (context) => AppBarBloc(),
        child: EditImageScreen(imageFile: imageFile),
      ),
    );
  }
}

class EditImageScreen extends StatefulWidget {
  final File imageFile;
  final PickImageScreenBloc pickImageScreenBloc;

  EditImageScreen({this.imageFile, this.pickImageScreenBloc});

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  AppBarBloc appBarBloc;
  EditImageScreenBloc editImageScreenBloc;
  int currentColor = 0xffffffff; //White color

  @override
  Widget build(BuildContext context) {
    appBarBloc = BlocProvider.of<AppBarBloc>(context);
    editImageScreenBloc = BlocProvider.of<EditImageScreenBloc>(context);

    return WillPopScope(
      onWillPop: () {
        //TODO - check why the event of widget.pickImageScreenBloc doesnt send back the bloc
        NavigatorHelper.navigateBackToPreviousScreen(context);
        widget.pickImageScreenBloc.add(EnterPickImageScreenEvent());

        return Future.value(true);
      },
      child: Scaffold(
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
                  BlocBuilder<EditImageScreenBloc, EditImageScreenState>(
                    builder: (context, state) {
                      print('first state is $state');
                      if (state is AddParametersSuccessState) {
                        return EditImageWidget(
                            color: currentColor, imageFile: widget.imageFile);
                      } else if (state is ImageFilterSuccessState) {
                        currentColor = state.currentColor;
                        print('current color is $currentColor');
                        return EditImageWidget(
                            color: state.currentColor,
                            imageFile: widget.imageFile);
                      } else if (state is AddFiltersSuccessState) {
                        return EditImageWidget(
                            color: currentColor, imageFile: widget.imageFile);
                      }
                      return Container();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          editImageScreenBloc
                              .add(ParametersButtonHasBeenPressed());
                        },
                        child: Icon(
                          Icons.mode_edit,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
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
                      GestureDetector(
                        onTap: () {
                          editImageScreenBloc
                              .add(FiltersButtonHasBeenPressed());
                        },
                        child: Icon(
                          Icons.palette,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(color: Colors.white),
                  ),
                  BlocListener<EditImageScreenBloc, EditImageScreenState>(
                    listener: (context, state) {},
                    child:
                        BlocBuilder<EditImageScreenBloc, EditImageScreenState>(
                      builder: (context, state) {
                        print('state is $state');
                        if (state is EditImageScreenInitialState) {
                          //When enter the screen the default is parametersMenu
                          return ParametersMenuWidget();
                        } else if (state is AddParametersSuccessState) {
                          return ParametersMenuWidget();
                        } else if (state is AddFiltersSuccessState) {
                          return Container(
                              margin: EdgeInsets.only(top: 30.0),
                              height: 100.0,
                              width: double.infinity,
                              child: FiltersList(
                                  filters: state.filters,
                                  bloc: editImageScreenBloc));
                        } else if (state is ImageFilterSuccessState) {
                          editImageScreenBloc.add(FiltersButtonHasBeenPressed());
                          return Container(
                              margin: EdgeInsets.only(top: 30.0),
                              height: 100.0,
                              width: double.infinity,
                              child: FiltersList(
                                  filters: state.filters,
                                  bloc: editImageScreenBloc));
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    editImageScreenBloc.close();
    appBarBloc.close();
  }
}
