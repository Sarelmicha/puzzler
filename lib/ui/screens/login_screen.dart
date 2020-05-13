import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_event.dart';
import 'package:puzzlechat/bloc/login_bloc/login_state.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/navigator_helper.dart';
import 'package:puzzlechat/util/contstants.dart';
import 'package:puzzlechat/ui/widgets/icon_text_field.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';



class LoginScreenParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController phoneController = TextEditingController();
  LoginBloc loginBloc;
  Country _selected;


  @override
  Widget build(BuildContext context) {

    loginBloc = BlocProvider.of<LoginBloc>(context);

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
            Text(
              'Puzzler',
              style: kLogoTextStyle
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {

                if (state is LoginLoadingState) {
                  NavigatorHelper.navigateToSplashScreen(context);
                }
                else if (state is LoginSuccessState) {
                  NavigatorHelper.navigateToLobbyScreen(context, state.user);
                }
                else if(state is CodeState) {

                  NavigatorHelper.navigateToSMSCodeScreenScreen(context,state.verificationId);

                }
                else if (state is LoginFailureState) {
                  NavigatorHelper.navigateBackToPreviousScreen(context);
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                   if (state is LoginFailureState) {
                    return Text(
                      state.message,
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(width: 10.0),
            IconTextField(
              controller: phoneController,
              hint: "Phone Number",
              obscureText: false,
              prefix: CountryPicker(
                showDialingCode: true,
                showFlag:  false,
                showName: false,
                onChanged: (Country country) {
                  setState(() {
                    _selected = country;
                  });
                },
                selectedCountry: _selected,
              ),
              textInputType: TextInputType.phone,
              iconData: Icons.phone,
              padding: EdgeInsets.all(10),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              text: "Login",
              width: 200,
              height: 42,
              onPressed: () {
                print('phone number is +${_selected.dialingCode}${phoneController.text.trim()}');
                loginBloc.add(LoginButtonPressedEvent(
                 phoneNumber: '+${_selected.dialingCode}${phoneController.text.trim()}'
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
    loginBloc.close();
  }
}
