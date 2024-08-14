import 'package:e_commerce_app/views/widgets/custom_icon.dart';
import 'package:flutter/material.dart';

class AppBarProduct extends StatelessWidget {
  const AppBarProduct({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIcon(
          icon: Icons.arrow_back_ios,
          iconColor: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
         CustomIcon(
          icon: Icons.shopping_cart,
          iconColor: Colors.black,
          onPressed:onPressed ,
        ),
      ],
    );
  }
}
