import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_bloc.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_event.dart';
import 'package:puzzlechat/bloc/pick_image_screen_bloc/pick_image_screen_state.dart';
import 'package:puzzlechat/util/contstants.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:puzzlechat/util/navigator_helper.dart';

class PickImageScreenParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PickImageScreenBloc>(
      create: (context) =>
          PickImageScreenBloc()..add(EnterPickImageScreenEvent()),
      child: PickImageScreen(),
    );
  }
}

class PickImageScreen extends StatefulWidget {
  @override
  _PickImageScreenState createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  bool _enabled = false;
  PickImageScreenBloc pickImageScreenBloc;

  @override
  Widget build(BuildContext context) {
    pickImageScreenBloc = BlocProvider.of<PickImageScreenBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzler', style: kLogoTextStyle.copyWith(fontSize: 30.0)),
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
              // do something
            },
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.purpleAccent, Colors.pinkAccent]),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: <Widget>[
              BlocListener<PickImageScreenBloc, PickImageScreenState>(
                listener: (context, state) {

                  print('state from screen is $state');

                  if (state is CameraSuccessState) {
                    NavigatorHelper.navigateToEditImageScreen(
                        context, state.imageFile);
                  } else if (state is GallerySuccessState) {
                    NavigatorHelper.navigateToEditImageScreen(
                        context, state.imageFile);
                  }
                },
                child: BlocBuilder<PickImageScreenBloc, PickImageScreenState>(
                  builder: (context, state) {
                    if (state is AnimationSuccess) {
                      _enabled = true;
                    }

                    return Column(
                      children: <Widget>[
                        DottedBorder(
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          strokeWidth: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 30.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('Smile!',
                                      style: kLogoTextStyle.copyWith(
                                        fontSize: 40.0,
                                      )),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  ShakeAnimatedWidget(
                                    enabled: _enabled,
                                    duration: Duration(milliseconds: 1500),
                                    shakeAngle: Rotation.deg(z: -10),
                                    curve: Curves.linear,
                                    child: GestureDetector(
                                      onTap: () {
                                        pickImageScreenBloc
                                            .add(CameraPressedEvent());
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 60.0,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'OR',
                            style: kLogoTextStyle.copyWith(fontSize: 20.0),
                          ),
                        ),
                        DottedBorder(
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          strokeWidth: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 30.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('Gallery',
                                      style: kLogoTextStyle.copyWith(
                                        fontSize: 40.0,
                                      )),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  ShakeAnimatedWidget(
                                    enabled: _enabled,
                                    duration: Duration(milliseconds: 1500),
                                    shakeAngle: Rotation.deg(z: 10),
                                    curve: Curves.linear,
                                    child: GestureDetector(
                                      onTap: () {
                                        pickImageScreenBloc
                                            .add(GalleryPressedEvent());
                                      },
                                      child: Icon(
                                        Icons.photo,
                                        color: Colors.white,
                                        size: 60.0,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pickImageScreenBloc.close();
  }
}
