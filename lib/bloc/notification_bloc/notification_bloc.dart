import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_event.dart';
import 'package:puzzlechat/bloc/login_bloc/login_state.dart';
import 'package:puzzlechat/bloc/notification_bloc/notifcation_event.dart';
import 'package:puzzlechat/bloc/notification_bloc/notification_state.dart';



class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {


  @override
  NotificationState get initialState => NotificationInitialState();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {

  }
}
