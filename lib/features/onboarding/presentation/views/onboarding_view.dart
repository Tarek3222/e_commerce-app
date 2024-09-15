import 'package:e_commerce_app/features/onboarding/presentation/views/widget/onboarding_view_body.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  static const onboardingViewId = 'onboardingView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: OnBoardingViewBody(),
    );
  }
}