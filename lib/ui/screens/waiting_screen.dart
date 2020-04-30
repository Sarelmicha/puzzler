import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/bloc_provider.dart';
import 'package:puzzlechat/bloc/cell_bloc.dart';
import 'package:puzzlechat/bloc/image_piece_bloc.dart';
import 'package:puzzlechat/ui/screens/game_screen.dart';

class WaitingScreen extends StatefulWidget {
  
  final int numOfRows;
  WaitingScreen({this.numOfRows});
  
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}


class _WaitingScreenState extends State<WaitingScreen> {

  ImagePieceBloc imagePieceBloc;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Waiting...')),
      color: Colors.white,
    );
  }

  @override
  void initState() {
    super.initState();
    initApp();
  }
  
  void initApp() async {

    var imageData = await getImage();
    final cellBloc = BlocProvider.of<CellBloc>(context);
    cellBloc.createCells();
    imagePieceBloc = ImagePieceBloc(imageData: imageData, numOfRows: widget.numOfRows);
    imagePieceBloc.createImagePieces(widget.numOfRows);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => GameScreen(
      numOfRows: widget.numOfRows,
      startTime: 10,
      imagePieceBloc: imagePieceBloc,
      cellBloc: cellBloc,)));
  }

  Future<Uint8List> getImage() async  {
    var byteData = await _convertImage();
    return byteData.buffer.asUint8List();
  }

  Future<ByteData> _convertImage()  {
    return DefaultAssetBundle.of(context).load("assets/image.jpg");
  }
}
