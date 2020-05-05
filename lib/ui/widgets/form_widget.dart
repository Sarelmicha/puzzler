import 'package:flutter/material.dart';
import 'package:puzzlechat/ui/widgets/icon_text_field.dart';

class FormWidget extends StatelessWidget {

  final TextEditingController emailController;
  final TextEditingController passwordController;


  FormWidget({@required this.emailController, @required this.passwordController });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IconTextField(
          controller: emailController,
          hint: "Email",
          obscureText: false,
          textInputType: TextInputType.text,
          iconData: Icons.email,
          padding: EdgeInsets.all(10),
        ),
        IconTextField(
          controller: passwordController,
          hint: "Password",
          obscureText: true,
          textInputType: TextInputType.text,
          iconData: Icons.lock,
          padding: EdgeInsets.all(10),
        ),
      ],
    );
  }
}
