
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/bloc.dart';
import 'package:puzzlechat/data/image_piece.dart';
import 'package:image/image.dart' as imglib;

class ImagePieceBloc implements Bloc {

  var _imagePieces = <ImagePiece>[];
  var _orderImagePieces = <ImagePiece>[];
  var imageData;
  int numOfRows;

  ImagePieceBloc({this.imageData,this.numOfRows});

  List<ImagePiece> get imagePieces => _imagePieces;

  List<ImagePiece> get orderImagePieces => _orderImagePieces;

  final _controller = StreamController<List<ImagePiece>>();
  Stream<List<ImagePiece>> get stream => _controller.stream;

  void createImagePieces(int numOfRows) {

    print('now in fumc imageData is $imageData');

    int numOfPieces = numOfRows * numOfRows;

    List<Image> images = splitImage(imageData);

    if(images.isEmpty){
      return;
    }

    for(int i = 0; i < numOfPieces; i++){
      _imagePieces.add(
          ImagePiece(
          index: i,
          image: images[i]
      ));

      _orderImagePieces.add(
          ImagePiece(
              index: i,
              image: images[i]
          ));
    }

    _mixImages();

    print('here before sink!!');

    _controller.sink.add(_imagePieces);
  }


  void deleteImage(int index){

    for(int i = 0; i < imagePieces.length; i++){
      if(_imagePieces[i].index == index){
        _imagePieces.removeAt(i);
      }
    }
    _controller.sink.add(_imagePieces);
  }

  @override
  void dispose() {
    _controller.close();
  }

  List<Image> splitImage(List<int> input) {

    if(input == null){
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
    List<Image> output = List<Image>();
    for (var img in parts) {
      output.add(Image.memory(
          imglib.encodeJpg(img),
        fit: BoxFit.fill,
      ));
    }


    return output;
  }

  void _mixImages() {

    Random random = Random();

    for(int i = 0; i < _imagePieces.length; i++){

      var temp = _imagePieces[i];
      var randomIndex = random.nextInt(_imagePieces.length - 1) ;
      _imagePieces[i] = _imagePieces[randomIndex];
      _imagePieces[randomIndex] = temp;

    }

  }

}
