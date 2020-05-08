import 'dart:io';

import 'package:flutter/material.dart';

class EditImageWidget extends StatelessWidget {
  final int color;
  final File imageFile;

  EditImageWidget({@required this.color, @required this.imageFile});

  @override
  Widget build(BuildContext context) {
    print('color is $color');
    return Container(
      width: double.infinity,
      height: 350,
      padding: EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: TweenAnimationBuilder(
          tween: ColorTween(begin: Colors.white, end: Color(color)),
          duration: Duration(milliseconds: 0),
          builder: (_, Color color, __) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(color, BlendMode.modulate),
              child: Image.file(
                imageFile,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
