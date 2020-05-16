import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:puzzlechat/bloc/app_bar_bloc/app_bar_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_bloc/image_bloc.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_bloc/image_event.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_bloc/image_state.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_state.dart';
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
  final String receiverPhoneNumber;
  final FirebaseUser currentUser;
  final PickImageScreenBloc pickImageScreenBloc;

  EditImageScreenParent(
      {this.imageFile,
      this.pickImageScreenBloc,
      this.receiverPhoneNumber,
      this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditImageScreenBloc>(
      create: (context) => EditImageScreenBloc(
        imageFile,
      )..add(ParametersButtonHasBeenPressed()),
      child: BlocProvider(
        create: (context) => ImageBloc(imageFile: imageFile),
        child: BlocProvider<AppBarBloc>(
          create: (context) => AppBarBloc(),
          child: EditImageScreen(
              imageFile: imageFile,
              receiverPhoneNumber: receiverPhoneNumber,
              currentUser: currentUser),
        ),
      ),
    );
  }
}

class EditImageScreen extends StatefulWidget {
  final File imageFile;
  final PickImageScreenBloc pickImageScreenBloc;
  final String receiverPhoneNumber;
  final FirebaseUser currentUser;

  EditImageScreen(
      {this.imageFile,
      this.pickImageScreenBloc,
      this.receiverPhoneNumber,
      this.currentUser});

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  AppBarBloc appBarBloc;
  EditImageScreenBloc editImageScreenBloc;
  ImageBloc imageBloc;
  Color parametersIcon = Color(0xffb000e0);
  Color stickersIcon = Colors.white;
  Color filtersIcon = Colors.white;

  int currentColor = 0xffffffff; //White color
  int currentTotalTime = 30;
  int currentNumOfPieces = 9;
  int currentImageRotation = 0;

  @override
  Widget build(BuildContext context) {
    appBarBloc = BlocProvider.of<AppBarBloc>(context);
    editImageScreenBloc = BlocProvider.of<EditImageScreenBloc>(context);
    imageBloc = BlocProvider.of<ImageBloc>(context);

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
                  BlocBuilder<ImageBloc, ImageState>(
                    builder: (context, state) {
                      print('state from roatation bloc is $state');

                      if (state is RotationSuccessState) {
                        //User changed image rotation
                        currentImageRotation = state.rotation;
                        imageBloc.add(RotationChangedEvent());
                      } else if (state is SelectFilterSuccessState) {
                        //User change filter image.
                        currentColor = state.currentColor;
                        imageBloc.add(FilterChangedEvent());
                      }
                      return RotatedBox(
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
                          setState(() {
                            filtersIcon = Colors.white;
                            parametersIcon = Color(0xffb000e0);
                            stickersIcon = Colors.white;
                          });
                        },
                        child: Icon(
                          Icons.mode_edit,
                          color: parametersIcon,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      LikeButton(
                        onTap: onRotationButtonTapped,
                        size: 30,
                        circleColor: CircleColor(
                            start: Colors.purpleAccent, end: Colors.purple),
                        bubblesColor: BubblesColor(
                            dotPrimaryColor: Colors.pink,
                            dotSecondaryColor: Colors.pinkAccent),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.rotate_right,
                            color: Colors.white,
                            size: 30.0,
                          );
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.star,
                        color: stickersIcon,
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          editImageScreenBloc
                              .add(FiltersButtonHasBeenPressed());

                          setState(() {
                            filtersIcon = Color(0xffb000e0);
                            parametersIcon = Colors.white;
                            stickersIcon = Colors.white;
                          });
                        },
                        child: Icon(
                          Icons.palette,
                          color: filtersIcon,
                          size: 30.0,
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
                      if (state is SendImageSuccessState) {
                        //NavigatorHelper.navigateToLobbyScreen(context,widget.currentUser);
                        print(
                            'send image success state! navigate back to lobby...');
                        NavigatorHelper.navigateToLobbyScreen(
                            context, widget.currentUser);
                      }
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
                            receiverPhoneNumber: widget.receiverPhoneNumber,
                            senderPhoneNumber: widget.currentUser.phoneNumber,
                            bloc: editImageScreenBloc,
                          );
                        } else if (state
                            is ParametersBottomScreenSuccessState) {
                          return ParametersMenuWidget(
                              totalTime: currentTotalTime,
                              numOfPieces: currentNumOfPieces,
                              receiverPhoneNumber: widget.receiverPhoneNumber,
                              senderPhoneNumber: widget.currentUser.phoneNumber,
                              bloc: editImageScreenBloc);
                        } else if (state is FiltersBottomScreenSuccessState) {
                          return Container(
                              margin: EdgeInsets.only(top: 30.0, left: 5.0),
                              height: 100.0,
                              width: double.infinity,
                              child: FiltersList(
                                  filters: state.filters, bloc: imageBloc));
                        } else if (state is ChangeTimerSuccessState) {
                          //User change total time
                          currentTotalTime = state.totalTime;
                          editImageScreenBloc.add(ParameterChangedEvent());
                          return ParametersMenuWidget(
                              totalTime: currentTotalTime,
                              numOfPieces: currentNumOfPieces,
                              receiverPhoneNumber: widget.receiverPhoneNumber,
                              senderPhoneNumber: widget.currentUser.phoneNumber,
                              bloc: editImageScreenBloc);
                        } else if (state is ChangePiecesSuccessState) {
                          //User change number of pieces
                          currentNumOfPieces = state.numOfPieces;
                          editImageScreenBloc.add(ParameterChangedEvent());
                          return ParametersMenuWidget(
                              totalTime: currentTotalTime,
                              numOfPieces: currentNumOfPieces,
                              receiverPhoneNumber: widget.receiverPhoneNumber,
                              bloc: editImageScreenBloc);
                        } else if (state is ChangeParametersSuccessState) {
                          return ParametersMenuWidget(
                              totalTime: currentTotalTime,
                              numOfPieces: currentNumOfPieces,
                              receiverPhoneNumber: widget.receiverPhoneNumber,
                              senderPhoneNumber: widget.currentUser.phoneNumber,
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
    imageBloc.close();
  }

  Future<bool> onRotationButtonTapped(bool isLiked) async {
    imageBloc.add(RotateButtonHasBeenPressed());

    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
}
