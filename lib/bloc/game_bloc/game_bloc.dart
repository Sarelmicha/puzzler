import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/game_bloc/game_event.dart';
import 'package:puzzlechat/data/cell.dart';
import 'package:puzzlechat/data/image_piece.dart';
import 'package:image/image.dart' as imglib;

import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  int numOfRows;
  List<Cell> _cells = <Cell>[];
  List<ImagePiece> _imagePieces = <ImagePiece>[];
  List<ImagePiece> _orderImagePieces = <ImagePiece>[];
  File imageFile;

  List<Cell> get cells => _cells;
  List<ImagePiece> get orderImagePieces => _orderImagePieces;


  GameBloc({this.imageFile,this.numOfRows});

  @override
  GameState get initialState => GameInitialState();

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is GameStartedEvent) {
      print('here in game started event!');
      yield GameLoadingState();

      print('before create cells');
      createCells();
      print('after create cells');
      print('before convertImageToByteData');
      Uint8List convertedImage = convertImageToByteData(imageFile);
      print('after convertImageToByteData');
      print('before createImagePieces');
      createImagePieces(convertedImage);
      print('after createImagePieces');


      print('here fter all initialze of puzzle!');


      yield GameReadyState(cells: _cells, imagePieces: _imagePieces);

      print('here fter yield  game ready state');


    } else if (event is CellHasBeenFieldEvent) {
      fillCell(event.index);
      deleteImage(event.index);
      yield FillCellSuccessState();
      bool isUserWon = isWin();
      if (isUserWon) {
        yield GameOverState(isUserWon: isUserWon);
      } else {
        yield ContinueGameState(cells: _cells,imagePieces: _imagePieces);
      }
    }
  }

  void createCells() {
    print('num of rows = $numOfRows');
    int numOfCells = numOfRows * numOfRows;

    for (int i = 0; i < numOfCells; i++) {
      _cells.add(Cell(index: i));
    }
  }

  void createImagePieces(Uint8List imageData) {
    print('now in fumc imageData is $imageData');

    int numOfPieces = numOfRows * numOfRows;

    List<ClipRRect> images = splitImage(imageData);

    if (images.isEmpty) {
      return;
    }

    for (int i = 0; i < numOfPieces; i++) {
      _imagePieces.add(ImagePiece(index: i, image: images[i]));
      _orderImagePieces.add(ImagePiece(index: i, image: images[i]));
    }

    _mixImages();
  }

  void deleteImage(int index) {
    for (int i = 0; i < _imagePieces.length; i++) {
      if (_imagePieces[i].index == index) {
        _imagePieces.removeAt(i);
      }
    }
  }

  List<ClipRRect> splitImage(List<int> input) {
    if (input == null) {
      return [];
    }

    // convert image to image from image package
    imglib.Image image = imglib.decodeImage(input);

    int x = 0, y = 0;
    int width = (image.width / numOfRows).round();
    int height = (image.height / numOfRows).round();

    // split image to parts
    List<imglib.Image> parts = List<imglib.Image>();
    for (int i = 0; i < numOfRows; i++) {
      for (int j = 0; j < numOfRows; j++) {
        parts.add(imglib.copyCrop(image, x, y, width, height));
        x += width;
      }
      x = 0;
      y += height;
    }

    // convert image from image package to Image Widget to display
    List<ClipRRect> output = List<ClipRRect>();
    for (var img in parts) {
      output.add(ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.memory(
          imglib.encodeJpg(img),
          fit: BoxFit.fill,
        ),
      ));
    }

    return output;
  }

  void _mixImages() {
    Random random = Random();

    for (int i = 0; i < _imagePieces.length; i++) {
      var temp = _imagePieces[i];
      var randomIndex = random.nextInt(_imagePieces.length - 1);
      _imagePieces[i] = _imagePieces[randomIndex];
      _imagePieces[randomIndex] = temp;
    }
  }

  Uint8List convertImageToByteData(File imageFile) {
    var byteData = imageFile.readAsBytesSync();
    return byteData;
  }

  void fillCell(int index) {
    for (Cell cell in _cells) {
      if (cell.index == index) {
        cell.isFilled = true;
        break;
      }
    }
  }

  bool isWin() {
    for (Cell cell in _cells) {
      if (!cell.isFilled) {
        return false;
      }
    }
    return true;
  }
}
