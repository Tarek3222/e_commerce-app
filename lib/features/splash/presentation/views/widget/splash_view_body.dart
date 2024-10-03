// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}
class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash_image.jpg'),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 160,
            color: Colors.pinkAccent,
          ),
          Text(
            'Shopping Online',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent,
            ),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      navigateUser();
    });
  }
  void navigateUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool(kKeepMeLoggedIn) ?? false;
    if (status) {
      Navigator.pushReplacementNamed(context, HomeView.homeViewId);
    } else {
       Navigator.pushReplacementNamed(context, OnboardingView.onboardingViewId);
    }
  }
}
