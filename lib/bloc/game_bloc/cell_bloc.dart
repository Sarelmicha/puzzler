//
//
//import 'dart:async';
//import 'package:puzzlechat/data/cell.dart';
//
//class CellBloc implements Bloc {
//
//  int numOfRows;
//  var _cells = <Cell>[];
//  List<Cell> get cells => _cells;
//
//  final _controller = StreamController<List<Cell>>();
//  Stream<List<Cell>> get stream => _controller.stream;
//
//  CellBloc({this.numOfRows});
//
//  Future<void> createCells() async {
//
//    int numOfCells = numOfRows * numOfRows;
//
//    for(int i = 0; i < numOfCells; i++){
//      _cells.add(Cell(index: i));
//    }
//    _controller.sink.add(_cells);
//  }
//
//  void fillCell(int index){
//
//    for(Cell cell in _cells){
//      if(cell.index == index){
//        cell.isFilled = true;
//        break;
//      }
//    }
//  }
//
//  @override
//  void dispose() {
//    _controller.close();
//  }
//
//  bool isWin(){
//
//    for(Cell cell in _cells){
//      if(!cell.isFilled){
//        return false;
//      }
//    }
//    return true;
//
//  }
//}
