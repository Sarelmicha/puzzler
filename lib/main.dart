import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/bloc_provider.dart';
import 'package:puzzlechat/bloc/cell_bloc.dart';
import 'package:puzzlechat/ui/screens/game_screen.dart';
import 'package:puzzlechat/ui/screens/waiting_screen.dart';

void main() => runApp(PuzzleChat());

class PuzzleChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CellBloc>(
      bloc: CellBloc(numOfRows: 3),
      child: MaterialApp(
        home: WaitingScreen(numOfRows: 3),
      ),
    );
  }
}


