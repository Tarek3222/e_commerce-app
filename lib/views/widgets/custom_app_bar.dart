import 'package:e_commerce_app/views/widgets/custom_icon.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.onPressed, this.logOut});
 final void Function()? onPressed;
 final void Function()? logOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'DISCOVER',
          style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 20, fontWeight: FontWeight.bold),
        ),
       Row(
         children: [
           CustomIcon(icon: Icons.shopping_cart,iconColor: Colors.black,onPressed: onPressed,),
          const SizedBox(width: 10,),
           CustomIcon(icon: Icons.logout,iconColor: Colors.black,onPressed: logOut,),
         ],
       ),
      ],
    );
  }
}
