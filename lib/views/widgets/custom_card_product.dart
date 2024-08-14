import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class CustomCardProduct extends StatelessWidget {
  const CustomCardProduct({super.key, required this.product, this.onTap, required this.titleColor, required this.subtitleColor, required this.backgroundColor});

  final ProductModel product;
  final void Function(TapUpDetails)? onTap;
  final Color titleColor;
  final Color subtitleColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 40,
                offset: const Offset(10, 10), // changes position of shadow
              ),
            ]),
            child: Card(
              color: backgroundColor,
              elevation: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style:  TextStyle(
                          color: titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price}',
                          style:  TextStyle(fontSize: 16,color: subtitleColor),
                        ),
                        Text(
                          'count:${product.quantity}',
                          style:  TextStyle(fontSize: 16,color: subtitleColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -85,
            right: 10,
            child: Image.network(
              product.imageLocation,
              height: 130,
              width: 130,
            ),
          )
        ],
      ),
    );
  }
}
