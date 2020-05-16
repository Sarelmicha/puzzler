//
//
//import 'dart:async';
//
//
//class TimerBloc implements Bloc {
//
//  int startTime;
//
//  final _controller = StreamController<int>();
//  Stream<int> get stream => _controller.stream;
//
//  TimerBloc({this.startTime});
//
//  void start() {
//
//    startTime -= 1;
//
//    if(startTime < 0){
//      return;
//    }
//    _controller.sink.add(startTime);
//  }
//
//
//  @override
//  void dispose() {
//    _controller.close();
//  }
//}
