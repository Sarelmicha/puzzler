

import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {

  final List<int> items;
  final Function onChanged;

  CustomDropDown({@required this.items, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      items: items.map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}