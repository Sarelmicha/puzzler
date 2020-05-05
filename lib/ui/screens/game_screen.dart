//import 'dart:async';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:puzzlechat/bloc/game_bloc/cell_bloc.dart';
//import 'package:puzzlechat/bloc/game_bloc/image_piece_bloc.dart';
//import 'package:puzzlechat/bloc/game_bloc/timer_bloc.dart';
//import 'package:puzzlechat/data/cell.dart';
//import 'package:puzzlechat/data/image_piece.dart';
//import 'package:puzzlechat/ui/widgets/cell_widget.dart';
//import 'package:puzzlechat/ui/widgets/image_piece_widget.dart';
//import 'package:puzzlechat/ui/widgets/timer_widget.dart';
//
//class GameScreen extends StatefulWidget {
//
//
//  @override
//  _GameScreenState createState() => _GameScreenState();
//}
//
//class _GameScreenState extends State<GameScreen> {
//
//  List<ImagePiece> orderImagePieces;
//  List<ImagePiece> inorderImagePieces;
//  bool orderImagesHasSet = false;
//  Timer timer;
//  TimerBloc timerBloc;
//  int numOfRows;
//  int startTime;
//  ImagePieceBloc imagePieceBloc;
//  CellBloc cellBloc;
//  String imageUrl;
//  GameData gameDetails;
//
//
//  @override
//  void initState() {
//
//    gameDetails = ModalRoute.of(context).settings.arguments;
//
//    timerBloc = TimerBloc(startTime: gameDetails.totalTime);
//
//    //Start timer
//    timer =
//        Timer.periodic(Duration(seconds: 1), (Timer t) => timerBloc.start());
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: Container(
//              decoration: BoxDecoration(
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.pink,
//                      blurRadius:
//                          20.0, // has the effect of softening the shadow
//                      spreadRadius:
//                          1.0, // has the effect of extending the shadow
//                      offset: Offset(
//                        5.0, // horizontal, move right 10
//                        5.0, // vertical, move down 10
//                      ),
//                    )
//                  ],
//                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0)),
//                  gradient: LinearGradient(
//                      begin: Alignment.topRight,
//                      end: Alignment.bottomLeft,
//                      colors: [Colors.pink, Colors.pinkAccent]
//                  )
//              ),
//              width: double.infinity,
//              height: double.infinity,
//              padding: EdgeInsets.all(5.0),
//              child: Align(
//                alignment: Alignment.center,
//                  child: TimerWidget(timerBloc: timerBloc, startTime: gameDetails.totalTime)),
//            ),
//          ),
//          SizedBox(
//           height: 20.0,
//          ),
//          _buildBoard(context, gameDetails.numOfRows, gameDetails.imagePieceBloc),
//          SizedBox(
//            height: 20.0,
//          ),
//          _buildImagePieceContainer(
//              context, gameDetails.numOfRows, gameDetails.imagePieceBloc),
//        ],
//      ),
//    );
//  }
//
//  Widget _buildBoard(
//      BuildContext context, int numOfRows, ImagePieceBloc imagePieceBloc) {
//    return Padding(
//      padding: EdgeInsets.symmetric(horizontal: 10.0),
//      child: Container(
//          width: double.infinity,
//          height: 340.0,
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.all(Radius.circular(20)),
//            boxShadow: [
//              BoxShadow(
//                color: Colors.black,
//                blurRadius: 3.0,
//              ),
//            ],
//            border: Border.all(
//              color: Colors.purpleAccent,
//              width: 2.0,
//            ),
//          ),
//          child: _buildCellStreamBuilder(numOfRows)),
//    );
//  }
//
//  Widget _buildCellStreamBuilder(int numOfRows) {
//    return StreamBuilder(
//      stream: gameDetails.cellBloc.stream,
//      builder: (context, snapshot) {
//        final List<Cell> cells = snapshot.data;
//        return _buildCellsBoard(cells, numOfRows);
//      },
//    );
//  }
//
//  GridView _buildCellsBoard(List<Cell> cells, int numOfRows) {
//    List<DragTarget> pieces = [];
//
//    for (int i = 0; i < numOfRows * numOfRows; i++) {
//      pieces.add(_buildDragTarget(i));
//    }
//
//    return GridView.count(
//      primary: false,
//      padding: const EdgeInsets.all(0),
//      crossAxisSpacing: 0,
//      mainAxisSpacing: 0,
//      crossAxisCount: numOfRows,
//      children: pieces,
//    );
//  }
//
//  Widget _buildImagePieceContainer(
//      BuildContext context, int numOfRows, ImagePieceBloc imagePieceBloc) {
//    return BlocProvider<ImagePieceBloc>(
//      bloc: imagePieceBloc,
//      child: Flexible(
//        child: Container(
//          decoration: BoxDecoration(
//              boxShadow: [
//                BoxShadow(
//                  color: Colors.purple,
//                  blurRadius: 20.0, // has the effect of softening the shadow
//                  spreadRadius: 5.0, // has the effect of extending the shadow
//                  offset: Offset(
//                    10.0, // horizontal, move right 10
//                    10.0, // vertical, move down 10
//                  ),
//                )
//              ],
//              borderRadius: BorderRadius.all(Radius.circular(10.0)),
//              gradient: LinearGradient(
//                  begin: Alignment.topRight,
//                  end: Alignment.bottomLeft,
//                  colors: [Colors.purple, Colors.purpleAccent])),
//          width: double.infinity,
//          height: double.infinity,
//          padding: EdgeInsets.all(5.0),
//          child: Row(
//            children: <Widget>[
//              Icon(
//                  Icons.chevron_left,
//                  color: Colors.white,
//                  size: 30,
//              ),
//              Container(
//                  padding: EdgeInsets.all(20.0),
//                  width: 250.0,
//                  height: 200.0,
//                  margin: EdgeInsets.symmetric(horizontal: 20.0),
//                  child: _buildImagePieceStreamBuilder(imagePieceBloc, numOfRows)
//              ),
//              Icon(
//                Icons.chevron_right,
//                color: Colors.white,
//                size: 30,
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildImagePieceStreamBuilder(
//      ImagePieceBloc imagePieceBloc, int numOfRows) {
//    return StreamBuilder(
//      stream: imagePieceBloc.stream,
//      builder: (context, snapshot) {
//        inorderImagePieces = snapshot.data;
//
//        if (!snapshot.hasData) {
//          return Center(
//              child: Text(
//            'Loading...',
//            style: TextStyle(
//              fontSize: 10.0,
//              fontWeight: FontWeight.bold,
//            ),
//          ));
//        }
//
//        if (!orderImagesHasSet) {
//          orderImagePieces = imagePieceBloc.orderImagePieces;
//          orderImagesHasSet = true;
//        }
//        return _buildImagePieces(inorderImagePieces, numOfRows);
//      },
//    );
//  }
//
//  Widget _buildImagePieces(List<ImagePiece> imagesPieces, int numOfRows) {
//    return ListView.separated(
//      scrollDirection: Axis.horizontal,
//      itemCount: imagesPieces.length,
//      separatorBuilder: (context, index) => Divider(),
//      itemBuilder: (context, index) {
//        final imagePiece = imagesPieces[index];
//
//        //Building a single ImagePieceWidget details UI for any index.
//        return LongPressDraggable<int>(
//          data: imagePiece.index,
//          child: gameDetails.cellBloc.cells[imagePiece.index].isFilled
//              ? Container(width: 0, height: 0)
//              : ImagePieceWidget(
//                  imagePiece: imagePiece,
//                  margin: EdgeInsets.all(5.0),
//                ),
//          feedback: ImagePieceWidget(
//            imagePiece: imagePiece,
//            margin: EdgeInsets.all(5.0),
//          ),
//          childWhenDragging: Container(width: 0, height: 0),
//        );
//      },
//    );
//  }
//
//  DragTarget _buildDragTarget(
//    int index,
//  ) {
//    return DragTarget<int>(
//      builder: (BuildContext context, List<int> incoming, List rejected) {
//        if (gameDetails.cellBloc.cells[index].isFilled) {
//          return CellWidget(
//            child: ImagePieceWidget(
//              imagePiece: orderImagePieces[index],
//              margin: EdgeInsets.all(0),
//            ),
//          );
//        } else {
//          return CellWidget(
//            child: null,
//          );
//        }
//      },
//      onWillAccept: (imagePieceIndex) =>
//          imagePieceIndex == gameDetails.cellBloc.cells[index].index,
//      onAccept: (imagePieceIndex) {
//        gameDetails.cellBloc.fillCell(imagePieceIndex);
//        gameDetails.imagePieceBloc.deleteImage(imagePieceIndex);
//        if (gameDetails.cellBloc.isWin()) {
//          print('user win');
////          _saveScreen();
//        }
//      },
//    );
//  }
//}
