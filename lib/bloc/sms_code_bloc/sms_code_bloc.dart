
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/sms_code_bloc/sms_code_event.dart';
import 'package:puzzlechat/bloc/sms_code_bloc/sms_code_state.dart';
import 'package:puzzlechat/repository/user_repository.dart';

class SMSCodeBloc extends Bloc<SMSCodeEvent,SMSCodeState> {

  UserRepository userRepository;


  SMSCodeBloc() {
    this.userRepository = UserRepository();
  }

  @override
  SMSCodeState get initialState => SMSCodeInitial();


  @override
  Stream<SMSCodeState> mapEventToState(SMSCodeEvent event) async* {

    if (event is CodeButtonPressedEvent) {
      print('here in SMSBloc before loaingState');
        yield SMSCodeLoadingState();
      print('here in SMSBloc after loaingState');
      FirebaseUser user;
       await userRepository.signInWithCredential(user,event.verificationId, event.smsCode);

       print('user from smsCodeBloc is $user');
       if(user != null) {
         yield SMSCodeSuccessful(user: user);
       } else {
         SMSCodeFailure(message: 'Error');
       }
    }
  }



}
