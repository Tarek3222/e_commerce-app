import 'package:e_commerce_app/views/widgets/carts_body.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  static const String id = '/CartView';

  @override
  Widget build(BuildContext context) {
    String email=ModalRoute.of(context)!.settings.arguments as String;
    return  Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      backgroundColor: Colors.white,
      body:  CartsBody(email : email),
    );
  }
}