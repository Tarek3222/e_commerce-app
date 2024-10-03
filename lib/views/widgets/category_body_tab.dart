import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/views/widgets/category_tile.dart';
import 'package:flutter/material.dart';

class CategoryBodyTab extends StatelessWidget {
  const CategoryBodyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    'CATEGORY',
                    colors: [
                      Colors.black,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/offers.jpg',
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.2,
                children: [
                  categoryTile(context, kAndroidMobileCategory,
                      'assets/images/android_mobile.jpg'),
                  categoryTile(
                      context, kIphoneCategory, 'assets/images/iphone1.jpg'),
                  categoryTile(
                      context, kTabletsCategory, 'assets/images/tablets.jpg'),
                  categoryTile(
                      context, kLabtopsCategory, 'assets/images/labtops.jpg'),
                  categoryTile(
                      context, kIpadCategory, 'assets/images/ipad.jpg'),
                  categoryTile(
                      context, kCamerasCategory, 'assets/images/camera.jpg'),
                  categoryTile(
                      context, kWatchesCategory, 'assets/images/watch.jpg'),
                  categoryTile(context, kPcCategory, 'assets/images/pc.jpg'),
                  categoryTile(
                      context, kPlayStationCategory, 'assets/images/ps.jpg'),
                  categoryTile(context, kTvCategory, 'assets/images/tv.jpg'),
                  categoryTile(
                      context, kOthersCategory, 'assets/images/other.jpg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
