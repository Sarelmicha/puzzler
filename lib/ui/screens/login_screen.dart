import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_event.dart';
import 'package:puzzlechat/bloc/login_bloc/login_state.dart';
import 'package:puzzlechat/ui/widgets/form_widget.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/navigator_helper.dart';
import 'package:puzzlechat/util/contstants.dart';

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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginBloc loginBloc;


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
                else if (state is LoginFailureState) {
                  NavigatorHelper.navigateBackToCurrentScreen(context);
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                   if (state is LoginFailureState) {
                    return Text(
                      state.message,
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(width: 10.0),
            FormWidget(
              emailController: emailController,
              passwordController: passwordController,
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
                loginBloc.add(LoginButtonPressedEvent(
                  email: emailController.text,
                  password: passwordController.text,
                ));
              },
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Text(
                "Don't have an account? Signup",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                NavigatorHelper.navigateToSignupScreen(context);
              },
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
