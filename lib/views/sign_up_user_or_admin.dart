import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/views/sign_up_view.dart';
import 'package:e_commerce_app/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SignUpUserOrAdmin extends StatelessWidget {
  const SignUpUserOrAdmin({super.key});
  static const id = '/sign-up-user-or-admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Account as: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
           const SizedBox(height: 10,),
           CustomButton(text: 'User', onPressed: (){
             Navigator.pushNamed(context, SignUpView.signUpViewId, arguments: kUser);
           }),
           const SizedBox(height: 10,),
           CustomButton(text: 'Admin', onPressed: (){
            Navigator.pushNamed(context, SignUpView.signUpViewId, arguments: kAdmin);
           }),
          ],
        ),
      ),
    );
  }
}
