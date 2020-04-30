
import 'package:flutter/material.dart';
import 'package:puzzlechat/data/image_piece.dart';

class ImagePieceWidget extends StatelessWidget {

  final ImagePiece imagePiece;

  ImagePieceWidget({this.imagePiece});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: 120,
      height: 120,
      child: imagePiece.image,
    );
  }
}
