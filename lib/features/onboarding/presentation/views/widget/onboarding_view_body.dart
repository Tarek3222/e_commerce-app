import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/features/onboarding/data/models/onboarding_model.dart';
import 'package:e_commerce_app/features/onboarding/presentation/views/widget/custom_button.dart';
import 'package:e_commerce_app/features/onboarding/presentation/views/widget/dot_indicator.dart';
import 'package:e_commerce_app/features/onboarding/presentation/views/widget/on_boarding_content.dart';
import 'package:e_commerce_app/features/auth/presentation/views/log_in_view.dart';
import 'package:flutter/material.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Expanded(
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            allowImplicitScrolling: true,
            controller: pageController,
            itemCount: OnBoardModel.onBoardList.length,
            itemBuilder: (context, index) {
              return OnBoardingContent(
                image: OnBoardModel.onBoardList[index].image,
                title: OnBoardModel.onBoardList[index].title,
                subTitle: OnBoardModel.onBoardList[index].subTitle,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            currentPage == 1
                ? const SizedBox()
                : CustomButton(
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LogInView.loginVeiwId);
                    },
                    textStyle: const TextStyle(
                        color: AppColors.myGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    text: "skip",
                    borderRadius: BorderRadius.circular(30),
                  ),
            const SizedBox(
              width: 50,
            ),
            ...List.generate(
              OnBoardModel.onBoardList.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DotIndicator(
                  isActive: currentPage == index,
                ),
              ),
            ),
            const SizedBox(
              width: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: ElevatedButton(
                onPressed: () {
                  pageController.animateToPage(currentPage + 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInToLinear);
                  if (currentPage == 1) {
                    Navigator.pushReplacementNamed(
                        context, LogInView.loginVeiwId);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.myGrey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: currentPage == 1
                    ? const Text("Get Started")
                    : const Icon(
                        Icons.arrow_forward_rounded,
                      ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ));
  }
}
