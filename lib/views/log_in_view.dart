import 'package:e_commerce_app/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});
  static const loginVeiwId='LogInView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginViewBody(),
    );
  }
}
