import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class InfoOfUser extends StatelessWidget {
  const InfoOfUser({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: user.image.isNotEmpty
          ? CircleAvatar(
              radius: 30,
              backgroundImage: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: user.image,
              ).image,
            )
          : const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person),
            ),
      title: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: Text(
          user.name,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16),
        ),
      ),
      subtitle: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: Text(
          user.email,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }
}
