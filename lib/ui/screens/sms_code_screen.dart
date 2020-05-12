import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/sms_code_bloc/sms_code_bloc.dart';
import 'package:puzzlechat/bloc/sms_code_bloc/sms_code_event.dart';
import 'package:puzzlechat/bloc/sms_code_bloc/sms_code_state.dart';
import 'package:puzzlechat/ui/widgets/icon_text_field.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/navigator_helper.dart';


class SMSCodeScreenParent extends StatelessWidget {

  final String verificationId;

  SMSCodeScreenParent({this.verificationId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SMSCodeBloc>(
      create: (context) => SMSCodeBloc(),
      child: SMSCodeScreen(verificationId: verificationId),
    );
  }
}


class SMSCodeScreen extends StatefulWidget {

  final String verificationId;

  SMSCodeScreen({this.verificationId});

  @override
  _SMSCodeScreenState createState() => _SMSCodeScreenState();
}

class _SMSCodeScreenState extends State<SMSCodeScreen> {
  final TextEditingController smsCodeController = TextEditingController();

  SMSCodeBloc smsCodeBloc;

  @override
  Widget build(BuildContext context) {

    smsCodeBloc = BlocProvider.of<SMSCodeBloc>(context);

    return Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.purpleAccent, Colors.pinkAccent]
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocListener<SMSCodeBloc, SMSCodeState>(
                  listener: (context, state) {

                    if (state is SMSCodeLoadingState) {
                      NavigatorHelper.navigateToSplashScreen(context);
                    }
                    else if (state is SMSCodeSuccessful) {
                      NavigatorHelper.navigateToLobbyScreen(context, state.user);
                    }
                    else if (state is SMSCodeFailure) {
                      NavigatorHelper.navigateBackToPreviousScreen(context);
                    }
                  },
                  child: BlocBuilder<SMSCodeBloc, SMSCodeState>(
                    builder: (context, state) {
                      return Container();
                    },
                  ),
                ),
                SizedBox(width: 10.0),
                IconTextField(
                  controller: smsCodeController,
                  hint: "Enter SMS code",
                  obscureText: false,
                  textInputType: TextInputType.text,
                  iconData: Icons.email,
                  padding: EdgeInsets.all(10),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                RoundedButton(
                  text: "Go!",
                  width: 200,
                  height: 42,
                  onPressed: () {
                    smsCodeBloc.add(CodeButtonPressedEvent(
                      verificationId: widget.verificationId,
                        smsCode: smsCodeController.text.trim()
                    ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    smsCodeBloc.close();
  }
}
