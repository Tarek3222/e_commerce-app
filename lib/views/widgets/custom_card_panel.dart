import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomCardPanel extends StatelessWidget {
  const CustomCardPanel({super.key, required this.title, required this.icon, this.onTap});
  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 40,
                offset: const Offset(10, 10), // changes position of shadow
              ),
            ],
          ),
          child: Card(
            color: Colors.black,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Icon(icon,size: 30,color: Colors.white,),
                Text(title,style:const TextStyle(color: Colors.white),),
              ],),
            ),
          ),
        ),
    );
  }
}