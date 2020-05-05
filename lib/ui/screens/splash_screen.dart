import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzlechat/ui/screens/lobby_screen.dart';
import 'package:puzzlechat/util/contstants.dart';

import 'game_screen.dart';

class SplashScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Puzzler',
          style: GoogleFonts.greatVibes(
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = kLinearGradient,
          ),
        ),
      ),
    );
  }

//  void handleRouting() {
//
//    data = ModalRoute.of(context).settings.arguments;
//
//    switch (data['operation']) {
//      case Operation.LOGIN:
//        login();
//        break;
//
//      case Operation.SIGNUP:
//       signUp();
//        break;
//    }
//  }

  //---------------------------------------------------------------

  //Inside this lines important lines DO NOT DELETE!

//  Future<void> prepareGame() async {
//    var imageData = await getImage(screenArguments.imgUrl);
//    final cellBloc = BlocProvider.of<CellBloc>(context);
//    ImagePieceBloc imagePieceBloc = ImagePieceBloc(
//        imageData: imageData, numOfRows: screenArguments.numOfRows);
//
//    //cal functions of bloc
//    await cellBloc.createCells();
//    await imagePieceBloc.createImagePieces();
//
//    screenArguments.setCellBloc = cellBloc;
//    screenArguments.imagePieceBloc = imagePieceBloc;
//
//    navigateToGame();
//  }

//  Future<Uint8List> getImage(String imgUrl) async {
//    var byteData = await _convertImage(imgUrl);
//    return byteData.buffer.asUint8List();
//  }
//
//  Future<ByteData> _convertImage(String imgUrl) {
//    return DefaultAssetBundle.of(context).load(imgUrl);
//  }

  //-----------------------------------------------------------

//  void navigateToLobby()  {
//
//      Navigator.pushNamed(context, LobbyScreen.id);
//  }
//
//  void navigateToGame() {
//     Navigator.pushNamed(context, GameScreen.id);
//  }

//  void login() async {
//
//    Timer.periodic(Duration(seconds: 3), (t){
//      navigateToLobby();
//    });

//    TODO - authenicate user with firebase.
//
//    TODO - Grab all users from phone list of user


//  }

//  void signUp() {
//
//    Timer.periodic(Duration(seconds: 3), (t){
//      navigateToLobby();
//    });
//
//  }
}
