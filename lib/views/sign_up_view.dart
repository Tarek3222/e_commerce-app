import 'package:e_commerce_app/views/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const signUpViewId='signUpView';
  @override
  Widget build(BuildContext context) {
    String type = ModalRoute.of(context)!.settings.arguments as String;
    return  Scaffold(
      body: SignUpViewBody(type: type,),
    );
  }
}