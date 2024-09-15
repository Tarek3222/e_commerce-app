import 'package:flutter/material.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});
  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image),
        const SizedBox(
          height: 40,
        ),
        Text(
          title,
          style: const TextStyle(
              
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              height: 1.5,
              letterSpacing: 0.5,
              color: Colors.black.withOpacity(0.8),
            ),
            softWrap: true,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
