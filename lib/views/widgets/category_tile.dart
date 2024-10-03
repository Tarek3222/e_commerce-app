import 'package:e_commerce_app/views/widgets/products_by_categories.dart';
import 'package:flutter/material.dart';

Widget categoryTile(
  BuildContext context,
  String categoryName,
  String imagePath,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductesByCategories(
                    category: categoryName,
                  )));
    },
    child: Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: Image.asset(imagePath).image,
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
      ),
      child: Center(
        child: Text(
          categoryName,
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
