import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomOffer extends StatelessWidget {
  const CustomOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
            gradient: const LinearGradient(
                colors: [Colors.yellow, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.02),
                color: Colors.grey[200]),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 4),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.02),
                      color: Colors.white),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        const Color.fromARGB(255, 224, 224, 224)
                            .withOpacity(0.5),
                        BlendMode.srcATop),
                    child: const Icon(
                      Icons.local_offer_outlined,
                      color: AppColors.kPrimaryColor,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 230,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 250,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.orange,
                            shadows: [
                              Shadow(
                                blurRadius: 7.0,
                                color: Colors.white,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: true,
                            repeatForever: true,
                            animatedTexts: [
                              FlickerAnimatedText(
                                'find favorite products',
                                speed: const Duration(seconds: 2),
                              ),
                              FlickerAnimatedText(
                                'Shop with confidence !',
                                speed: const Duration(seconds: 2),
                              ),
                              FlickerAnimatedText(
                                "shopping by discount 47%",
                                speed: const Duration(seconds: 2),
                              ),
                            ],
                            onTap: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
