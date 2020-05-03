
import 'package:flutter/material.dart';
import 'package:puzzlechat/data/cell.dart';

class CellWidget extends StatelessWidget {

  final Cell cell;
  final Widget child;

  CellWidget({this.cell,this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
        width: 100.0,
        height: 100.0,
        child: child,
        color: Colors.white,
    );
  }
}
