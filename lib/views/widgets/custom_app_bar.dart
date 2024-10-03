import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/views/search_view.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedTextKit(
            isRepeatingAnimation: true,
            repeatForever: true,
            animatedTexts: [
              WavyAnimatedText(
                'DISCOVER',
                textStyle: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ]),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchView(
                    products: products,
                  ),
                ),
              );
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black54),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'find your product',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Icon(Icons.search, color: Colors.black54),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
