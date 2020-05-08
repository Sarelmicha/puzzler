import 'dart:io';

import 'package:flutter/material.dart';


class Filter {

  bool isPicked;
  File imageFile;
  String filterName;

  Filter({@required this.isPicked, @required this.imageFile, @required this.filterName});

}