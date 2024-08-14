import 'package:e_commerce_app/views/widgets/custom_icon.dart';
import 'package:flutter/material.dart';

class Headers extends StatelessWidget {
  const Headers({super.key, required this.title, this.isSignOut=false, this.onPressed});
  final String title;
  final bool? isSignOut ;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      height: 120,
      decoration: const BoxDecoration(color: Colors.black),
      alignment: Alignment.bottomLeft,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:const EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  title,
                  style:const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
         isSignOut!? Row(
            children: [
              CustomIcon(icon: Icons.logout,iconColor: Colors.white,
              onPressed: onPressed,
              ),
             const SizedBox(
                width: 10,
              ),
            ],
          ):const SizedBox(
            width: 0,)
        ],
      ),
    );
  }
}
