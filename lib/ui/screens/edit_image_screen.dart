import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/filter_bloc/filter_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/filter_bloc/filter_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/filter_bloc/filter_state.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/rotation_bloc/rotation_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/rotation_bloc/rotation_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/rotation_bloc/rotation_state.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_bloc.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_event.dart';
import 'package:puzzlechat/ui/widgets/edit_image_widget.dart';
import 'package:puzzlechat/ui/widgets/parameters_menu_widget.dart';
import 'package:puzzlechat/util/contstants.dart';
import 'package:puzzlechat/util/navigator_helper.dart';
import 'package:puzzlechat/ui/widgets/filters_list.dart';

import '../../bloc/edit_image_screen_bloc/edit_image_screen_state.dart';




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
      child: BlocProvider(
        create: (context) => FilterBloc(imageFile: imageFile),
        child: BlocProvider(
          create: (context) => RotationBloc(),
          child: BlocProvider<AppBarBloc>(
            create: (context) => AppBarBloc(),
            child: EditImageScreen(imageFile: imageFile),
          ),
        ),
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
  RotationBloc rotationBloc;
  FilterBloc filterBloc;

  int currentColor = 0xffffffff; //White color
  int currentTotalTime = 30;
  int currentNumOfPieces = 9;
  int currentImageRotation = 0;

  @override
  Widget build(BuildContext context) {

    appBarBloc = BlocProvider.of<AppBarBloc>(context);
    editImageScreenBloc = BlocProvider.of<EditImageScreenBloc>(context);
    rotationBloc = BlocProvider.of<RotationBloc>(context);
    filterBloc = BlocProvider.of<FilterBloc>(context);

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
                  BlocBuilder<RotationBloc,EditImageScreenState>(
                    builder: (context,state) {
                       if(state is RotationSuccessState){
                      currentImageRotation = state.rotation;
                      }
                       return Container();
                    },
                  ),
                  BlocBuilder<FilterBloc, EditImageScreenState>(
                    builder: (context, state){
                      if (state is SelectFilterSuccessState) {
                        //User change filter image.
                        currentColor = state.currentColor;
                        filterBloc.add(FilterChangedEvent());
                      } return RotatedBox(
                        quarterTurns: currentImageRotation,
                        child: EditImageWidget(
                            color: currentColor, imageFile: widget.imageFile),
                      );
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
                      GestureDetector(
                        onTap: (){
                          editImageScreenBloc.add(RotateButtonHasBeenPressed());
                        },
                        child: Icon(
                          Icons.rotate_right,
                          color: Colors.white,
                        ),
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
                    listener: (context, state) {
                      //TODO- pass to next screen wehn Send button has been pressed
                    },
                    child:
                        BlocBuilder<EditImageScreenBloc, EditImageScreenState>(

                      builder: (context, state) {
                        //This blocBuilder show which bottom screen to show according to user choice
                        print('state is $state');
                        if (state is EditImageScreenInitialState) {
                          //When enter the screen the default is parametersMenu
                          return ParametersMenuWidget(
                            totalTime: currentTotalTime,
                            numOfPieces: currentNumOfPieces,
                            bloc: editImageScreenBloc,
                          );
                        } else if (state is ParametersBottomScreenSuccessState) {
                          return ParametersMenuWidget(
                              totalTime: currentTotalTime,
                              numOfPieces: currentNumOfPieces,
                              bloc: editImageScreenBloc);
                        } else if (state is FiltersBottomScreenSuccessState) {
                          return Container(
                              margin: EdgeInsets.only(top: 30.0, left: 5.0),
                              height: 100.0,
                              width: double.infinity,
                              child: FiltersList(
                                  filters: state.filters,
                                  bloc: filterBloc)
                          );
                        }
                        else if (state is ChangeTimerSuccessState) {
                          //User change total time
                          currentTotalTime = state.totalTime;
                          editImageScreenBloc.add(ParameterChangedEvent());
                          return ParametersMenuWidget(
                              totalTime: currentTotalTime,
                              numOfPieces: currentNumOfPieces,
                              bloc: editImageScreenBloc);
                        } else if (state is ChangePiecesSuccessState) {
                          //User change number of pieces
                          currentNumOfPieces = state.numOfPieces;
                          editImageScreenBloc.add(ParameterChangedEvent());
                          return ParametersMenuWidget(
                              totalTime: currentTotalTime,
                              numOfPieces: currentNumOfPieces,
                              bloc: editImageScreenBloc);
                        } else if(state is ChangeParametersSuccessState){
                          return ParametersMenuWidget(
                              totalTime: currentTotalTime,
                              numOfPieces: currentNumOfPieces,
                              bloc: editImageScreenBloc);
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
    rotationBloc.close();
    filterBloc.close();
  }
}
