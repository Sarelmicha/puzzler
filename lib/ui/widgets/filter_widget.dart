
import 'package:flutter/material.dart';
import 'package:puzzlechat/data/filter.dart';

class FilterWidget extends StatelessWidget {

  final Filter filter;

  FilterWidget({@required this.filter});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 50.0,
            backgroundImage: FileImage(filter.imageFile),
          ),
        ),
        Text(
          filter.filterName
        ),
      ],
    );
  }
}
