import 'package:e_commerce_app/features/auth/presentation/views/widget/back_ground_login.dart';
import 'package:e_commerce_app/features/auth/presentation/views/widget/login_form.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
            children: [
              const BackGroundView(ratio: 0.4,),
              const Positioned(
                top: 89,
                left: 20,
                child: Text(
                  "Log in",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              const Positioned(
                top: 140,
                left: 20,
                child: Text(
                  "Hey there! welcome back",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
              const Positioned(
                top: 189,
                left: 29,
                child: Text(
                  "Her are you dream",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const Positioned(
                top: 215,
                left: 29,
                child: Text(
                  "things",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 175,
                child: Image.asset(
                  'assets/images/login_image.png',
                  width: 180,
                  height: 200,
                ),
              ),
             const Positioned(
                top: 315,
                left: 20,
                right: 20,
                child: LoginForm(),
              ),
            ],
          ),
      ),
    );
  }
}