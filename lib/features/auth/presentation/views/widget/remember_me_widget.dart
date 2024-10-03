import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class RememberMeWidget extends StatelessWidget {
  const RememberMeWidget(
      {super.key, required this.keepMeLoggedIn, this.onChanged});
  final bool keepMeLoggedIn;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: keepMeLoggedIn,
          activeColor: kPrimaryColor,
          checkColor: Colors.white,
          onChanged: onChanged,
        ),
        const Text(
          'Remember me',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
