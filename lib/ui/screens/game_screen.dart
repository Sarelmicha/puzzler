import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/bloc_provider.dart';
import 'package:puzzlechat/bloc/cell_bloc.dart';
import 'package:puzzlechat/bloc/image_piece_bloc.dart';
import 'package:puzzlechat/bloc/timer_bloc.dart';
import 'package:puzzlechat/data/cell.dart';
import 'package:puzzlechat/data/image_piece.dart';
import 'package:puzzlechat/ui/widgets/cell_widget.dart';
import 'package:puzzlechat/ui/widgets/image_piece_widget.dart';
import 'package:puzzlechat/ui/widgets/timer_widget.dart';

class GameScreen extends StatefulWidget {
  final int numOfRows;
  final int startTime;
  final ImagePieceBloc imagePieceBloc;
  final CellBloc cellBloc;
  GameScreen({this.numOfRows, this.startTime,this.imagePieceBloc,this.cellBloc});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  List<ImagePiece> orderImagePieces;
  List<ImagePiece> inorderImagePieces;
  bool orderImagesHasSet = false;
  Timer timer;
  TimerBloc timerBloc;


  @override
  void initState() {

    timerBloc = TimerBloc(startTime: widget.startTime);
    //Start timer
    timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => timerBloc.start());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff1b1e31),
      body: Column(
        children: <Widget>[ 
          Expanded(child: Align(
            alignment: Alignment.center,
              child: TimerWidget(timerBloc: timerBloc, startTime: widget.startTime))),

          _buildBoard(context, widget.numOfRows, widget.imagePieceBloc),
          SizedBox(
            height: 20.0,
          ),
          _buildImagePieceContainer(context, widget.numOfRows, widget.imagePieceBloc),
        ],
      ),
    );
  }

  Widget _buildBoard(
      BuildContext context, int numOfRows, ImagePieceBloc imagePieceBloc) {


    return Container(
        width: 320.0,
        height: 320.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: _buildCellStreamBuilder(numOfRows)
    );
  }

  Widget _buildCellStreamBuilder(int numOfRows) {
    return StreamBuilder(
      stream: widget.cellBloc.stream,
      builder: (context, snapshot) {
        final List<Cell> cells = snapshot.data;
        return _buildCellsBoard(cells, numOfRows);
      },
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

  Widget _buildImagePieceContainer(
      BuildContext context, int numOfRows, ImagePieceBloc imagePieceBloc) {
    return BlocProvider<ImagePieceBloc>(
      bloc: imagePieceBloc,
      child: Flexible(
        child: Container(
            padding: EdgeInsets.all(12.0),
            width: double.infinity,
            height: 100.0,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: _buildImagePieceStreamBuilder(imagePieceBloc, numOfRows)),
      ),
    );
  }

  Widget _buildImagePieceStreamBuilder(
      ImagePieceBloc imagePieceBloc, int numOfRows) {
    return StreamBuilder(
      stream: imagePieceBloc.stream,
      builder: (context, snapshot) {
        inorderImagePieces = snapshot.data;

        if (!snapshot.hasData) {
          return Center(
              child: Text(
                  'Loading...',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),)
          );
        }

        if (!orderImagesHasSet) {
          orderImagePieces = imagePieceBloc.orderImagePieces;
          orderImagesHasSet = true;
        }
        return _buildImagePieces(inorderImagePieces, numOfRows);
      },
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
          child: widget.cellBloc.cells[imagePiece.index].isFilled
              ? Container(width: 100, height: 100)
              : ImagePieceWidget(imagePiece: imagePiece),
          feedback: ImagePieceWidget(imagePiece: imagePiece),
          childWhenDragging: ImagePieceWidget(imagePiece: imagesPieces[0]),
        );
      },
    );
  }

  DragTarget _buildDragTarget(
      int index,) {
    return DragTarget<int>(
      builder: (BuildContext context, List<int> incoming, List rejected) {
        if (widget.cellBloc.cells[index].isFilled) {
          return CellWidget(
            child: ImagePieceWidget(
              imagePiece: orderImagePieces[index],
            ),
          );
        } else {
          return CellWidget(
            child: null,
          );
        }
      },
      onWillAccept: (imagePieceIndex) => imagePieceIndex == widget.cellBloc.cells[index].index,
      onAccept: (imagePieceIndex) {
        widget.cellBloc.fillCell(imagePieceIndex);
        widget.imagePieceBloc.deleteImage(imagePieceIndex);
        if(widget.cellBloc.isWin()){
          print('user win');
          //TODO- do somthing when win
        }
      },
    );
  }

}
