import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/game_bloc/game_bloc.dart';
import 'package:puzzlechat/bloc/game_bloc/game_event.dart';
import 'package:puzzlechat/bloc/game_bloc/game_state.dart';
import 'package:puzzlechat/bloc/lobby_screen_bloc/lobby_screen_state.dart';
import 'package:puzzlechat/data/cell.dart';
import 'package:puzzlechat/data/image_piece.dart';
import 'package:puzzlechat/ui/widgets/cell_widget.dart';
import 'package:puzzlechat/ui/widgets/image_piece_widget.dart';
import 'package:puzzlechat/ui/widgets/timer_widget.dart';
import 'package:puzzlechat/util/navigator_helper.dart';

class GameScreenParent extends StatelessWidget {
  final FirebaseUser currentUser;
  final int totalTime;
  final int numOfRows;
  final Uint8List image;

  GameScreenParent(
      {this.totalTime, this.numOfRows, this.image, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      create: (context) =>
          GameBloc(image: image, numOfRows: numOfRows)..add(GameStartedEvent()),
      child: GameScreen(
          totalTime: totalTime, numOfRows: numOfRows, currentUser: currentUser),
    );
  }
}

class GameScreen extends StatefulWidget {
  final int totalTime;
  final int numOfRows;
  final FirebaseUser currentUser;

  GameScreen({this.totalTime, this.numOfRows, this.currentUser});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameBloc gameBloc;
  List<ImagePiece> orderImagePieces;
  bool orderImagesHasSet = false;
  int startTime;
  String imageUrl;
  bool isUserCanPlay;

  @override
  Widget build(BuildContext context) {
    gameBloc = BlocProvider.of<GameBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.purpleAccent, Colors.pinkAccent])),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink,
                        blurRadius:
                            20.0, // has the effect of softening the shadow
                        spreadRadius:
                            1.0, // has the effect of extending the shadow
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      )
                    ],
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.pink, Colors.pinkAccent])),
                width: double.infinity,
                height: 100.0,
                padding: EdgeInsets.all(5.0),
                child: Align(
                  child: TimerWidget(
                      totalTime: widget.totalTime, gameBloc: gameBloc),
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            BlocListener<GameBloc, GameState>(
              listener: (context, state) {
                if (state is GameLoadingState) {
                  NavigatorHelper.navigateToSplashScreen(context);
                } else if (state is GameReadyState) {
                  NavigatorHelper.navigateBackToPreviousScreen(context);
                  gameBloc.add(GameIsReadyEvent());
                }  else if (state is GameOverState) {
                  if (state.isUserWon) {
                    userWon();
                  } else {
                    userLost();
                  }
                }
                return Container();
              },
              child:
                  BlocBuilder<GameBloc, GameState>(builder: (context, state) {
                if (state is GameReadyState) {
                  orderImagePieces = gameBloc.orderImagePieces;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildBoard(
                        context,
                        widget.numOfRows,
                        state.cells,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildImagePieceContainer(
                          context, widget.numOfRows, state.imagePieces),
                    ],
                  );
                } else if (state is ContinueGameState) {
                  orderImagePieces = gameBloc.orderImagePieces;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildBoard(
                        context,
                        widget.numOfRows,
                        state.cells,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildImagePieceContainer(
                          context, widget.numOfRows, state.imagePieces),
                    ],
                  );
                } else if (state is CantPlayState) {
                  print('im here and user CANT play');
                  return Container();

                } else if (state is CanPlayState) {

                  orderImagePieces = gameBloc.orderImagePieces;

                 return Column(
                   mainAxisSize: MainAxisSize.min,
                   children: <Widget>[
                     _buildBoard(
                       context,
                       widget.numOfRows,
                       state.cells,
                     ),
                     SizedBox(
                       height: 20.0,
                     ),
                     _buildImagePieceContainer(
                         context, widget.numOfRows, state.imagePieces),
                   ],
                 );

                }
                return Container();
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    gameBloc.close();
  }

  Widget _buildBoard(BuildContext context, int numOfRows, List<Cell> cells) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
          width: double.infinity,
          height: 340.0,
          decoration: BoxDecoration(
            color: Colors.pink,
//            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 3.0,
              ),
            ],
            border: Border.all(
              color: Colors.purple,
              width: 2.0,
            ),
          ),
          child: _buildCellsBoard(cells, numOfRows)),
    );
  }

  GridView _buildCellsBoard(List<Cell> cells, int numOfRows) {
    List<DragTarget> pieces = [];

    for (int i = 0; i < numOfRows * numOfRows; i++) {
      pieces.add(_buildDragTarget(i));
    }

    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(0),
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: numOfRows,
      children: pieces,
    );
  }

  DragTarget _buildDragTarget(int index) {
    return DragTarget<int>(
      builder: (BuildContext context, List<int> incoming, List rejected) {
        if (gameBloc.cells[index].isFilled) {
          return CellWidget(
            child: ImagePieceWidget(
              imagePiece: orderImagePieces[index],
              margin: EdgeInsets.all(0),
            ),
          );
        } else {
          return CellWidget(
            child: null,
          );
        }
      },
      onWillAccept: (imagePieceIndex) {
        print(
            'imagePieceIndex is $imagePieceIndex and cell index is ${gameBloc.cells[index].index}');
        return imagePieceIndex == gameBloc.cells[index].index;
      },
      onAccept: (imagePieceIndex) {
        gameBloc.add(CellHasBeenFieldEvent(index: imagePieceIndex));
      },
    );
  }

  Widget _buildImagePieceContainer(
      BuildContext context, int numOfRows, List<ImagePiece> imagePieces) {
    print('build me baby!!!');
      print('here and user cannnn play!');
      return Flexible(
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.purple,
                  blurRadius: 20.0, // has the effect of softening the shadow
                  spreadRadius: 5.0, // has the effect of extending the shadow
                  offset: Offset(
                    10.0, // horizontal, move right 10
                    10.0, // vertical, move down 10
                  ),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.pink, Colors.pinkAccent])),
          width: double.infinity,
          height: 130.0,
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 30,
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  width: 250.0,
                  height: 200.0,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildImagePieces(imagePieces, numOfRows)),
              Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildImagePieces(List<ImagePiece> imagesPieces, int numOfRows) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: imagesPieces.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final imagePiece = imagesPieces[index];

        //Building a single ImagePieceWidget details UI for any index.
        return LongPressDraggable<int>(
          data: imagePiece.index,
          child: gameBloc.cells[imagePiece.index].isFilled
              ? Container(width: 0, height: 0)
              : ImagePieceWidget(
                  imagePiece: imagePiece,
                  margin: EdgeInsets.all(5.0),
                ),
          feedback: ImagePieceWidget(
            imagePiece: imagePiece,
            margin: EdgeInsets.all(5.0),
          ),
          childWhenDragging: Container(width: 0, height: 0),
        );
      },
    );
  }

  void userWon() {}

  void userLost() {
    NavigatorHelper.navigateToLobbyScreen(context, widget.currentUser);
  }
}
