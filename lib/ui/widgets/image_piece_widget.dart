
import 'package:flutter/material.dart';
import 'package:puzzlechat/data/image_piece.dart';

class ImagePieceWidget extends StatelessWidget {

  final ImagePiece imagePiece;
  final EdgeInsets margin;

  ImagePieceWidget({@required this.imagePiece,@required this.margin});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.zero,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow:[BoxShadow(
          color: Colors.white,
          blurRadius: 2.0,
        ),
        ],
      ),

      width: 120,
      height: 120,
      child: imagePiece.image,
    );
  }
}
