import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.iconLeading,
      required this.text,
      required this.onPressed});
  final IconData iconLeading;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconLeading,
        color: text == 'Logout' ? Colors.red : Colors.black,
      ),
      title: Text(
        text,
        style: TextStyle(color: text == 'Logout' ? Colors.red : Colors.black),
      ),
      onTap: onPressed,
      trailing: Icon(Icons.arrow_forward_ios,
          color: text == 'Logout' ? Colors.red : Colors.black),
    );
  }
}
