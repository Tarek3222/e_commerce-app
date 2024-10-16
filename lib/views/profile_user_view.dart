import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:e_commerce_app/views/widgets/profile_user_body.dart';
import 'package:flutter/material.dart';

class ProfileUserView extends StatelessWidget {
  const ProfileUserView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ProfileUserBody(user: user),
    );
  }
}
