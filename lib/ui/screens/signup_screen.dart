import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzlechat/bloc/reg_bloc/user_reg_bloc.dart';
import 'package:puzzlechat/bloc/reg_bloc/user_reg_event.dart';
import 'package:puzzlechat/bloc/reg_bloc/user_reg_state.dart';
import 'package:puzzlechat/ui/widgets/form_widget.dart';
import 'package:puzzlechat/ui/widgets/rounded_button.dart';
import 'package:puzzlechat/util/navigator_helper.dart';

class SignupPageParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRegBloc>(
      create: (context) => UserRegBloc(),
      child: SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   UserRegBloc userRegBloc;


   @override
   void dispose() {
     super.dispose();
     userRegBloc.close();
   }

   @override
  Widget build(BuildContext context) {

    userRegBloc = BlocProvider.of<UserRegBloc>(context);

    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.purpleAccent, Colors.pinkAccent])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

              Flexible(
                child: Text(
                  "It's free and only takes a minute",
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              BlocListener<UserRegBloc, UserRegState>(
                listener: (context, state) {

                  if (state is UserLoadingState) {
                    NavigatorHelper.navigateToSplashScreen(context);
                  } else if (state is UserRegSuccessful) {
                    NavigatorHelper.navigateToLobbyScreen(context, state.user);
                  }
                  else if (state is UserRegFailure) {
                    NavigatorHelper.navigateBackToCurrentScreen(context);
                  }
                },
                child: BlocBuilder<UserRegBloc, UserRegState>(
                  builder: (context, state) {

                    if (state is UserRegFailure) {
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
              SizedBox(
                height: 10.0,
              ),
              FormWidget(
                emailController: emailController,
                passwordController: passwordController,
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                text: 'Sign Up',
                width: 200,
                height: 42,
                onPressed: () async {
                  userRegBloc.add(SignUpButtonPressedEvent(
                      email: emailController.text,
                      password: passwordController.text));
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
