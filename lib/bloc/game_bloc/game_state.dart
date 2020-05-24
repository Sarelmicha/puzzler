import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzlechat/data/cell.dart';
import 'package:puzzlechat/data/image_piece.dart';

abstract class GameState extends Equatable {}

class GameInitialState extends GameState {
  @override
  List<Object> get props => null;
}

class GameLoadingState extends GameState {
  @override
  List<Object> get props => null;
}


class GameReadyState extends GameState {

  final List<Cell> cells;
  final List<ImagePiece> imagePieces;

  GameReadyState({@required this.cells,@required this.imagePieces});


  @override
  List<Object> get props => null;
}

class GameFailureState extends GameState {

  @override
  List<Object> get props => null;
}

class GameOverState extends GameState {

  final bool isUserWon;

  GameOverState({this.isUserWon});

  @override
  // TODO: implement props
  List<Object> get props => null;

}

class ContinueGameState extends GameState {

  final List<Cell> cells;
  final List<ImagePiece> imagePieces;


  ContinueGameState({this.cells,this.imagePieces});

  @override
  List<Object> get props => null;

}

class FillCellSuccessState extends GameState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class CantPlayState extends GameState {
  @override
  List<Object> get props => null;

}

class CanPlayState extends GameState {

  final List<Cell> cells;
  final List<ImagePiece> imagePieces;

  CanPlayState({this.cells, this.imagePieces});
  @override
  List<Object> get props => null;

}