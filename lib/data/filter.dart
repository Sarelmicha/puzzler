import 'dart:io';

import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/image_event.dart';


class Filter {

  bool isPicked;
  File imageFile;
  String filterName;
  int endColor;
  ImageEvent event;

  Filter({@required this.isPicked, @required this.imageFile, @required this.filterName, @required this.endColor, @required this.event});

}